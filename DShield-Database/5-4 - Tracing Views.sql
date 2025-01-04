USE [DShield]
GO

-- =============================================
-- Title:       Errors - Out Of Memory (#701) 
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Utility
-- Type:		View
-- Description:
--	After you enable the memory-optimized 
--	tempdb metadata (HkTempDB) feature, you may 
--	see the error 701 indicating out of memory 
--	exceptions for tempdb allocations and 
--	SQL Server Service crashes. In addition, 
--	you may see that the memory clerk MEMORYCLERK_XTP 
--	for In-Memory OLTP (Hekaton) is growing 
--	gradually or rapidly and doesn't shrink back. 
--	As the XTP memory grows without an upper limit, 
--	you see the following error message in SQL Server:
--
--		Disallowing page allocations for database 
--		'tempdb' due to insufficient memory in 
--		the resource pool 'default'. 
--		See 'http://go.microsoft.com/fwlink/?LinkId=510837' 
--		for more information.
--
--	When you run a query on the DMV dm_os_memory_clerks, 
--	you can see that pages memory allocated is 
--	high for memory clerk MEMORYCLERK_XTP. 
-- Note:
--	Further Instructions for resolving issues
--	can be found at the link below
-- Source:
--	https://learn.microsoft.com/en-us/troubleshoot/sql/database-engine/performance/memory-optimized-tempdb-out-of-memory
-- =============================================
CREATE VIEW [Utility].[OutOfMemoryErrors701] AS
	SELECT 
		name, 
		type, 
		memory_node_id, 
		pages_kb 
	FROM sys.dm_os_memory_clerks
	WHERE type = 'MEMORYCLERK_XTP' 
GO

-- =============================================
-- Title:       Errors - Schema Manager Entries
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Utility
-- Type:		View
-- Description:
--	Get the number of Schema Manager Entries
--	currently in the database, used for
--	troubleshooting out of memory error.
--	see source link.
-- Note:
--	Further Instructions for resolving issues
--	can be found at the link below
-- Source:
--	https://learn.microsoft.com/en-us/troubleshoot/sql/database-engine/performance/schemamgr-store-degrades-performance
-- =============================================
CREATE VIEW [Utility].[SchemaManagerEntriesCount] AS
	SELECT 
		entries_count AS [Entries]
	FROM sys.dm_os_memory_cache_counters
	WHERE name = 'SchemaMgr Store'
GO

-- =============================================
-- Title:       Virtual Memory - Usage 
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Utility
-- Type:		View
-- Description:
--	Check virtual memory commitments and 
--	reservations
-- =============================================
CREATE VIEW [Utility].[VirtualMemoryUsage] AS
	SELECT 
		name, 
		type, 
		virtual_memory_reserved_kb, 
		virtual_memory_committed_kb
	FROM sys.dm_os_memory_clerks
	WHERE 
		virtual_memory_reserved_kb != 0 OR 
		virtual_memory_committed_kb != 0
GO

-- =============================================
-- Title:       CPU - Expensive Queries 
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Utility
-- Type:		View
-- Description:
--	Retrieve a top 10 list of queries currently
--	running that are using the most CPU time
-- Source:
--	https://learn.microsoft.com/en-us/troubleshoot/sql/database-engine/performance/troubleshoot-high-cpu-usage-issues
-- =============================================
CREATE VIEW [Utility].[HighCPUQueries] AS
	SELECT TOP 10 
		s.session_id,
        r.status,
        r.cpu_time,
        r.logical_reads,
        r.reads,
        r.writes,
        r.total_elapsed_time / (1000 * 60) 'Elaps M',
        SUBSTRING(st.TEXT, (r.statement_start_offset / 2) + 1,
        ((CASE r.statement_end_offset
            WHEN -1 THEN DATALENGTH(st.TEXT)
            ELSE r.statement_end_offset
        END - r.statement_start_offset) / 2) + 1) AS statement_text,
        COALESCE(QUOTENAME(DB_NAME(st.dbid)) + N'.' + QUOTENAME(OBJECT_SCHEMA_NAME(st.objectid, st.dbid)) 
        + N'.' + QUOTENAME(OBJECT_NAME(st.objectid, st.dbid)), '') AS command_text,
        r.command,
        s.login_name,
        s.host_name,
        s.program_name,
        s.last_request_end_time,
        s.login_time,
        r.open_transaction_count
	FROM sys.dm_exec_sessions AS s
	JOIN sys.dm_exec_requests AS r ON r.session_id = s.session_id CROSS APPLY sys.Dm_exec_sql_text(r.sql_handle) AS st
	WHERE r.session_id != @@SPID
--ORDER BY r.cpu_time DESC
GO

-- =============================================
-- Title:       CPU - Expensive Queries 
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Utility
-- Type:		View
-- Description:
--	Retrieve a top 10 list of Historical queries
--	that used the most CPU time
-- Source:
--	https://learn.microsoft.com/en-us/troubleshoot/sql/database-engine/performance/troubleshoot-high-cpu-usage-issues
-- =============================================
CREATE VIEW [Utility].[HighCPUQueriesHistorical] AS
	SELECT TOP 10  
		qs.last_execution_time, 
		st.text AS batch_text,
		SUBSTRING(
			st.TEXT, 
			(qs.statement_start_offset / 2) + 1, 
			(
				(
					CASE qs.statement_end_offset 
					WHEN - 1 
					THEN DATALENGTH(st.TEXT) 
					ELSE qs.statement_end_offset 
					END - qs.statement_start_offset
				) / 2
			) + 1) AS statement_text,
		(qs.total_worker_time / 1000) / qs.execution_count AS avg_cpu_time_ms,
		(qs.total_elapsed_time / 1000) / qs.execution_count AS avg_elapsed_time_ms,
		qs.total_logical_reads / qs.execution_count AS avg_logical_reads,
		(qs.total_worker_time / 1000) AS cumulative_cpu_time_all_executions_ms,
		(qs.total_elapsed_time / 1000) AS cumulative_elapsed_time_all_executions_ms
	FROM sys.dm_exec_query_stats qs
	CROSS APPLY sys.dm_exec_sql_text(sql_handle) st
	--ORDER BY(qs.total_worker_time / qs.execution_count) DESC
GO

-- =============================================
-- Title:       CPU - Show Missing Indexes
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Utility
-- Type:		View
-- Description:
--	View to identify queries that cause high CPU 
--	usage and that contain at least one missing 
--	index in the query plan
--	Captures the Total CPU time spent by a query 
--	along with the query plan and total executions
-- Source:
--	https://learn.microsoft.com/en-us/troubleshoot/sql/database-engine/performance/troubleshoot-high-cpu-usage-issues
-- =============================================
CREATE VIEW [Utility].[HighCPUQueriesMissingIndexes] AS
	SELECT
		qs_cpu.total_worker_time / 1000 AS total_cpu_time_ms,
		q.[text],
		p.query_plan,
		qs_cpu.execution_count,
		q.dbid,
		q.objectid,
		q.encrypted AS text_encrypted
	FROM
	(
		SELECT TOP 500 
			qs.plan_handle,
			qs.total_worker_time,
			qs.execution_count 
		FROM sys.dm_exec_query_stats qs 
		ORDER BY qs.total_worker_time DESC
	) AS qs_cpu
	CROSS APPLY sys.dm_exec_sql_text(plan_handle) AS q
	CROSS APPLY sys.dm_exec_query_plan(plan_handle) p
	WHERE p.query_plan.exist('declare namespace 
		qplan = "http://schemas.microsoft.com/sqlserver/2004/07/showplan";
		//qplan:MissingIndexes')=1
GO

-- =============================================
-- Title:       CPU - Frequent Expensive Queries 
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Utility
-- Type:		View
-- Description:
--	Retrieve queries where Max and average CPU 
--	time exceeds 200 ms and executed more than 
--	1000 times
-- Source:
--	https://learn.microsoft.com/en-us/troubleshoot/sql/database-engine/performance/troubleshoot-high-cpu-usage-issues
-- =============================================
CREATE VIEW [Utility].[HighCPUQueriesFrequentExecution] AS
	SELECT 
		qs.total_worker_time/1000 AS total_cpu_time_ms,
		qs.max_worker_time/1000 AS max_cpu_time_ms,
		(qs.total_worker_time/1000)/execution_count AS average_cpu_time_ms,
		qs.execution_count,
		q.[text]
	FROM sys.dm_exec_query_stats qs 
	CROSS APPLY sys.dm_exec_sql_text(plan_handle) AS q
	WHERE (
		qs.total_worker_time/execution_count > 200*1000 OR 
		qs.max_worker_time > 200*1000 
		) AND execution_count > 1000
	--ORDER BY  qs.total_worker_time DESC 
GO

-- =============================================
-- Title:       CPU - Suggest Missing Indexes
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Utility
-- Type:		View
-- Description:
--	check for missing indexes and apply any 
--	recommended indexes that have high improvement 
--	measure values. Start with the top 5 or 10 
--	recommendations from the output that have the 
--	highest improvement_measure value. Those 
--	indexes have the most significant positive 
--	effect on performance. Decide whether you 
--	want to apply these indexes and make sure 
--	that performance testing is done for the 
--	application. 
--	Then, continue to apply missing-index 
--	recommendations until you achieve the desired 
--	application performance results.
-- Source:
--	https://learn.microsoft.com/en-us/troubleshoot/sql/database-engine/performance/troubleshoot-high-cpu-usage-issues
-- =============================================
CREATE VIEW [Utility].[HighCPUQueriesSuggestIndexFixes] AS
	SELECT 
		CONVERT(VARCHAR(30), GETDATE(), 126) AS runtime,
		mig.index_group_handle,
		mid.index_handle,
		CONVERT(
			DECIMAL(28, 1), 
			migs.avg_total_user_cost * 
			migs.avg_user_impact * 
			(migs.user_seeks + migs.user_scans)
		) AS improvement_measure,
		'CREATE INDEX missing_index_' + 
		CONVERT(VARCHAR, mig.index_group_handle) + '_' + 
		CONVERT(VARCHAR, mid.index_handle) + ' ON ' + 
		mid.statement + 
		' (' + ISNULL(mid.equality_columns,'') + 
			CASE 
				WHEN mid.equality_columns IS NOT NULL AND 
					mid.inequality_columns IS NOT NULL 
				THEN ','
				ELSE ''
			END + 
			ISNULL(mid.inequality_columns, '') + 
		')' + 
		ISNULL(' INCLUDE (' + mid.included_columns + ')','') AS create_index_statement,
		migs.*,
		mid.database_id,
		mid.[object_id]
	FROM sys.dm_db_missing_index_groups mig
	INNER JOIN sys.dm_db_missing_index_group_stats migs 
		ON migs.group_handle = mig.index_group_handle
	INNER JOIN sys.dm_db_missing_index_details mid 
		ON mig.index_handle = mid.index_handle
	WHERE CONVERT (DECIMAL (28, 1),
               migs.avg_total_user_cost * 
			   migs.avg_user_impact * 
			   (migs.user_seeks + migs.user_scans)
			) > 10
	--ORDER BY 
		--migs.avg_total_user_cost * 
		--migs.avg_user_impact * 
		--(migs.user_seeks + migs.user_scans) DESC
GO

-- =============================================
-- Title:       Tracing - Profiler Trace Summary
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Utility
-- Type:		View
-- Description:
--	Check for SQL Trace or XEvent tracing that 
--	affects the performance of SQL Server and 
--	causes high CPU usage with this Profiler
--	Tracer Summary. Helps with identifying active 
--	XEvent or Server traces
-- Related:
--	[Utility].[TraceEventDetails] and 
--	[Utility].[XEventSessionDetails]
-- Source:
--	https://learn.microsoft.com/en-us/troubleshoot/sql/database-engine/performance/troubleshoot-high-cpu-usage-issues
-- =============================================
CREATE VIEW [Utility].[ProfilerTraceSummary] AS
	SELECT 
		traceid, 
		property, 
		CONVERT(VARCHAR(1024), value) AS value 
	FROM::fn_trace_getinfo(default)
GO


-- =============================================
-- Title:       Tracing - Trace Event Details
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Utility
-- Type:		View
-- Description:
--	Check for SQL Trace or XEvent tracing that 
--	affects the performance of SQL Server and 
--	causes high CPU usage with the details
--	related to the Profiler Tracer Summary. 
--	Helps with identifying active XEvent or 
--	Server traces
-- Related:
--	[Utility].[ProfilerTraceSummary] and 
--	[Utility].[XEventSessionDetails]
-- Source:
--	https://learn.microsoft.com/en-us/troubleshoot/sql/database-engine/performance/troubleshoot-high-cpu-usage-issues
-- =============================================
CREATE VIEW [Utility].[TraceEventDetails] AS
	SELECT 
		trace_id,
		status,
		CASE WHEN row_number = 1 THEN path ELSE NULL end AS path,
		CASE WHEN row_number = 1 THEN max_size ELSE NULL end AS max_size,
		CASE WHEN row_number = 1 THEN start_time ELSE NULL end AS start_time,
		CASE WHEN row_number = 1 THEN stop_time ELSE NULL end AS stop_time,
		max_files,
		is_rowset,
		is_rollover,
		is_shutdown,
		is_default,
		buffer_count,
		buffer_size,
		last_event_time,
		event_count,
		trace_event_id,
		trace_event_name,
		trace_column_id,
		trace_column_name,
		expensive_event
	FROM (
		SELECT 
			t.id AS trace_id, 
			row_number() 
			OVER (
				PARTITION BY t.id 
				ORDER BY 
					te.trace_event_id, 
					tc.trace_column_id
				) AS row_number,
				t.status,
				t.path,
				t.max_size,
				t.start_time,
				t.stop_time,
				t.max_files,
				t.is_rowset,
				t.is_rollover,
				t.is_shutdown,
				t.is_default,
				t.buffer_count,
				t.buffer_size,
				t.last_event_time,
				t.event_count,
				te.trace_event_id,
				te.name AS trace_event_name,
				tc.trace_column_id,
				tc.name AS trace_column_name,
				CASE 
				WHEN te.trace_event_id IN (23, 24, 40, 41, 44, 45, 51, 52, 54, 68, 96, 97, 98, 113, 114, 122, 146, 180) 
				THEN CAST(1 as bit) ELSE CAST(0 AS BIT) 
			END AS expensive_event 
		FROM sys.traces t 
		CROSS APPLY::fn_trace_geteventinfo(t.id) AS e 
		JOIN sys.trace_events te 
			ON te.trace_event_id = e.eventid 
		JOIN sys.trace_columns tc 
			ON e.columnid = trace_column_id
		) AS x
GO
-- =============================================
-- Title:       Tracing - XEvent Session Details
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Utility
-- Type:		View
-- Description:
--	Check for SQL Trace or XEvent tracing that 
--	affects the performance of SQL Server and 
--	causes high CPU usage with the details
--	related to the Profiler Tracer Summary. 
--	Helps with identifying active XEvent or 
--	Server traces
-- Related:
--	[Utility].[ProfilerTraceSummary] and 
--	[Utility].[TraceEventDetails] 
-- Source:
--	https://learn.microsoft.com/en-us/troubleshoot/sql/database-engine/performance/troubleshoot-high-cpu-usage-issues
-- =============================================
CREATE VIEW [Utility].[XEventSessionDetails] AS
	SELECT 
		sess.NAME 'session_name', 
		event_name, 
		xe_event_name, 
		trace_event_id,
		CASE 
			WHEN xemap.trace_event_id IN (23, 24, 40, 41, 44, 45, 51, 52, 54, 68, 96, 97, 98, 113, 114, 122, 146, 180) 
			THEN Cast(1 AS BIT)
			ELSE Cast(0 AS BIT)
		END AS expensive_event
	FROM sys.dm_xe_sessions sess
	JOIN sys.dm_xe_session_events evt
		ON sess.address = evt.event_session_address
	INNER JOIN sys.trace_xe_event_map xemap
		ON evt.event_name = xemap.xe_event_name
GO

-- =============================================
-- Title:       Sessions - Existing 
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Utility
-- Type:		View
-- Description:
--	Check sessions and basic logged on details
-- =============================================
CREATE VIEW [Utility].[ExistingSessions] AS
	SELECT 
		session_id,
		login_time,
		host_name,
		program_name,
		status,
		nt_domain,
		nt_user_name,
		cpu_time,
		database_id,
		authenticating_database_id
	FROM sys.dm_exec_sessions 
	WHERE program_name IS NOT NULL
GO

-- =============================================
-- Title:       I/O - Utilization
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Utility
-- Type:		View
-- Description:
--	Check read/write and IO stats for database
-- =============================================
CREATE VIEW [Utility].[ProgramIOActivity] AS
	SELECT 
		session_id,
		database_id,
		program_name,
		last_request_start_time,
		last_request_end_time,
		reads,
		writes,
		logical_reads
	FROM sys.dm_exec_sessions 
	WHERE 
		reads > 0 OR 
		writes > 0 OR 
		logical_reads > 0
GO

-- =============================================
-- Title:       Memory - System Consumers
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Utility
-- Type:		View
-- Description:
--	Check what's using up all the memory
-- Source:
--	https://learn.microsoft.com/en-us/troubleshoot/sql/database-engine/performance/memory-optimized-tempdb-out-of-memory
-- =============================================
CREATE VIEW [Utility].[SystemMemoryConsumers] AS
	SELECT 
		memory_consumer_type_desc, 
		memory_consumer_desc, 
		allocated_bytes, 
		used_bytes
	FROM sys.dm_xtp_system_memory_consumers 
GO

-- =============================================
-- Title:       OS Loaded Modules - Debug
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Utility
-- Type:		View
-- Description:
--	Check Loaded Modules with Debug flag set
-- =============================================
CREATE VIEW [Utility].[OsLoadedModulesDebug] AS
SELECT 
	company,
	name,
	product_version,
	file_version,
	description,
	language
FROM sys.dm_os_loaded_modules
WHERE debug = 1
GO

-- =============================================
-- Title:       OS Loaded Modules - Patched
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Utility
-- Type:		View
-- Description:
--	Check Loaded Modules with Patched flag set
-- =============================================
CREATE VIEW [Utility].[OsLoadedModulesPatched] AS
SELECT 
	company,
	name,
	product_version,
	file_version,
	description,
	language
FROM sys.dm_os_loaded_modules
WHERE patched = 1
GO

-- =============================================
-- Title:       OS Loaded Modules - Pre-Release
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Utility
-- Type:		View
-- Description:
--	Check Loaded Modules with PreRelease flag set
-- =============================================
CREATE VIEW [Utility].[OsLoadedModulesPreRelease] AS
SELECT 
	company,
	name,
	product_version,
	file_version,
	description,
	language
FROM sys.dm_os_loaded_modules
WHERE prerelease = 1
GO

-- =============================================
-- Title:       OS Loaded Modules - Private Build
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Utility
-- Type:		View
-- Description:
--	Check Loaded Modules with PrivateBuild flag set
-- =============================================
CREATE VIEW [Utility].[OsLoadedModulesPrivateBuilds] AS
SELECT 
	company,
	name,
	product_version,
	file_version,
	description,
	language
FROM sys.dm_os_loaded_modules
WHERE private_build = 1
GO

-- =============================================
-- Title:       OS Loaded Modules - Special Build
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Utility
-- Type:		View
-- Description:
--	Check Loaded Modules with SpecialBuild flag set
-- =============================================
CREATE VIEW [Utility].[OsLoadedModulesSpecialBuilds] AS
SELECT 
	company,
	name,
	product_version,
	file_version,
	description,
	language
FROM sys.dm_os_loaded_modules
WHERE special_build = 1
GO

-- =============================================
-- Title:       OS Loaded Modules - 3rd Party
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Utility
-- Type:		View
-- Description:
--	Check Loaded Modules that are not from Microsoft
-- =============================================
CREATE VIEW [Utility].[OsLoadedModulesThirdParty] AS
SELECT 
	company,
	name,
	product_version,
	file_version,
	description,
	language
FROM sys.dm_os_loaded_modules
WHERE 
	company != 'Microsoft Corporation' AND
	language = 67699888
GO

-- =============================================
-- Title:       OS Loaded Modules - Non-English
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Utility
-- Type:		View
-- Description:
--	Check Loaded Modules that are not English Based
-- =============================================
CREATE VIEW [Utility].[OsLoadedModulesNonEnglish] AS
SELECT 
	company,
	name,
	product_version,
	file_version,
	description,
	language
FROM sys.dm_os_loaded_modules
WHERE language != 67699888
GO