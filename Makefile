env:
	docker run --network bridge --rm -e NVIDIA_VISIBLE_DEVICES=all --device=nvidia.com/gpu=all --security-opt=label=disable -v ./:/app -it nvidia/cuda:12.3.1-devel-ubuntu22.04 bash
build:
	cmake -S cubricks/ -B build/ -DCMAKE_EXPORT_COMPILE_COMMANDS=1
