#!/usr/bin/env python3

import sys

# git+https://github.com/yaleman/addonfactory-ucc-generator/@openapi-schema-fix-multi-input
if len(sys.argv) != 2:
    raise ValueError("Usage: parse_package_ref.py <package_ref>")

package_ref = sys.argv[1]

print(f"Parsing {package_ref}", file=sys.stderr)

output = ""


if package_ref.startswith("git+"):
    method = package_ref.split("+")[0]
    leftover = "+".join(package_ref.split("+")[1:])

    branch = None
    if "@" in leftover:
        atsplit = leftover.split("@")
        branch = atsplit[-1]
        leftover = "@".join(atsplit[:-1])
        print(f"Branch: {branch}", file=sys.stderr)
        output += f" --depth 1 --branch {branch} "
else:
    raise NotImplementedError(f"Can't parse package ref: {package_ref}")
output = f"{output} {leftover} package"
print(output)
