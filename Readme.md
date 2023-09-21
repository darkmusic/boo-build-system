# Boo Build System (Bake)

To build:
- Install Rust
- Install Cargo-Make
```shell
cd build
cargo make build-all
```

## Example Bake file
```boo
import Bake.IO.Extensions

Task("default", ["test"])

Task("compile", ["codeGen"]) do:
	print "> do compile stuff"

Task("dataLoad", ["codeGen"]) do:
	print "> do dataLoad stuff"

Task("codeGen") do:
	print "> do codeGen stuff"

Task("test", ["compile", "dataLoad"]) do:
	print "> do test stuff"
	print Configuration.test
```

## License
See [licence](license.txt).