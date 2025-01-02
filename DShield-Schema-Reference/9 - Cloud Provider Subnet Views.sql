USE [DShield]
GO

/*
 *  IP Address SQL Schema
 *  A schema to perform extremely fast CRUD an analysis operations in plain SQL
 *  Copyright (C) 2025  Curtis Dibble
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU Affero General Public License as
 *  published by the Free Software Foundation, either version 3 of the
 *  License, or (at your option) any later version.
 *  
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU Affero General Public License for more details.
 *  
 *  You should have received a copy of the GNU Affero General Public License
 *  along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */

-- =============================================
-- Title:       Reference - Cloud Provider Subnets
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		View
-- Description:
--  View to Select Subnets and their Owners
-- =============================================
CREATE VIEW [Reference].[CloudProviderSubnetOwnership] AS
SELECT
      [IPAddress].[FromBinary](ipa.[Value]) AS [Subnet]
      ,cld.[NetMask]
      ,cps.[Value] AS [Provider]
      ,cld.[Comment]
  FROM [Reference].[CloudProviderSubnetOwnership] cld
  JOIN [Reference].[CloudProviders] cps ON cps.[Id] = cld.[CloudProviderID]
  JOIN [Reference].[IPAddresses] ipa ON ipa.[Id] = cld.[SubnetID]
GO

-- =============================================
-- Title:       Reference - Cloud Provider 
--                          Subnet Ownership
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Reference].[CloudProviderSubnetOwnership] TO [ReferenceManager];
GO
-- =============================================
-- Title:       Reference - Cloud Provider 
--                          Subnet Ownership
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Reference].[CloudProviderSubnetOwnership] TO [ReferenceWriter]
GO
-- =============================================
-- Title:       Reference - Cloud Provider 
--                          Subnet Ownership
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT REFERENCES, SELECT ON OBJECT::[Reference].[CloudProviderSubnetOwnership] TO [ReferenceExecutor]; 
GO

-- =============================================
-- Title:       Reference - Cloud Provider 
--                          Subnet Ownership
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================
GRANT REFERENCES, SELECT ON [Reference].[CloudProviderSubnetOwnership] TO [ReferenceReader]
GO
