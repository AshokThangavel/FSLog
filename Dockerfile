ARG IMAGE=intersystemsdc/irishealth-community
FROM $IMAGE

WORKDIR /home/irisowner/dev

ARG TESTS=0
ARG MODULE="Web-FSLog"
ARG NAMESPACE="IRISAPP"

## Embedded Python environment
ENV IRISUSERNAME "_SYSTEM"
ENV IRISPASSWORD "SYS"
ENV IRISNAMESPACE "IRISAPP"
ENV PYTHON_PATH=/usr/irissys/bin/
ENV PATH "/usr/irissys/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/home/irisowner/bin"


RUN --mount=type=bind,src=.,dst=. \
    iris start IRIS && \
	iris session IRIS < iris.script && \
    ([ $TESTS -eq 0 ] || iris session iris -U $NAMESPACE "##class(%ZPM.PackageManager).Shell(\"test $MODULE -v -only\",1,1)") && \
    iris stop IRIS quietly
