from pathlib import Path
import pathlib
import os
DOMAIN_NAME = "EXAMPLE"
INSTALL_SCRIPT_NAME = "3-Install-DShield-Utilities-IPAddress.sql"
BASE_DIRECTORY = Path(__file__).parent

PERMISSIONS_CONTENTS = []
FILE_CONTENTS = []
CLEAN_CONTENTS = []
IGNORED = [BASE_DIRECTORY/x for x in ["bin", "obj"]]

def save_contents() -> None:
	file_contents = ""
	file_location = BASE_DIRECTORY.parent / INSTALL_SCRIPT_NAME
	for x in CLEAN_CONTENTS:
		print(x)
		file_contents += x
		file_contents += "\n"
	for x in PERMISSIONS_CONTENTS:
		print(x)
		file_contents += x
		file_contents += "\n"
	with open(file_location, "w") as f:
		f.write(file_contents)
	f.close()
	print(f"Wrote install script to: {file_location}")

def clean_contents() -> None:
	for x in FILE_CONTENTS:
		y = x.replace("$(Domain)", DOMAIN_NAME)
		CLEAN_CONTENTS.append(y)

def add_file_contents(file: Path) -> None:
	print(f"Found Definition File: {file}")
	with open(file, "r") as f:
		contents = f.readlines()
	f.close()
	contents = "\n".join(contents)
	contents = contents.replace("\n\n","\n")
	if str(file).endswith("Permissions.sql"):
		PERMISSIONS_CONTENTS.append(contents)
	else:
		FILE_CONTENTS.append(contents)

def get_file_paths() -> list:
	files = os.listdir(BASE_DIRECTORY)
	files = [BASE_DIRECTORY / x for x in files if x.endswith(".sql")]
	files = [x for x in files if x not in IGNORED] 
	return files

def main() -> None:
	for x in IGNORED:
		print(f"Ignoring: {x}")

	files = get_file_paths()
	for x in files:
		add_file_contents(x)
	clean_contents()
	save_contents()
	print("Done")

if __name__ == '__main__':
	main()