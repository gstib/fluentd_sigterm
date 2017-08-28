.PHONY: build_12
build_12:
	docker build --pull -t fluentd -f $$PWD/Dockerfile_12 .

.PHONY: build_14
build_14:
	docker build --pull -t fluentd -f $$PWD/Dockerfile_14 .

.PHONY: run_12
run_12: build_12
	-docker stop --time=1 fluentd_sigterm
	-docker rm fluentd_sigterm
	rm -f $$PWD/test_data/pos-auth.log
	rm -rf $$PWD/test_output
	docker run --name fluentd_sigterm -d \
	-v $$PWD/test_output:/fluentd/log \
	-v $$PWD/test_data:/var/log \
	-e FLUENTD_CONF=development.conf \
	fluentd
	sleep 10
	docker stop --time=600 fluentd_sigterm


.PHONY: run_14
run_14: build_14
	-docker stop --time=1 fluentd_sigterm
	-docker rm fluentd_sigterm
	rm -f $$PWD/test_data/pos-auth.log
	rm -rf $$PWD/test_output
	docker run --name fluentd_sigterm -d \
	-v $$PWD/test_output:/fluentd/log \
	-v $$PWD/test_data:/var/log \
	-e FLUENTD_CONF=development.conf \
	fluentd
	sleep 10
	docker stop --time=600 fluentd_sigterm

