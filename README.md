# Kasm-Ubuntu22.04-Image-Template
Template workspace for Kasm servers, includes base applications such as Google Chrome, as well as Canvas for students and other apps default on school provided computers.


## For making and changing versions use the following commands:

```bash
docker login

sudo docker build -t nighthawkcoders/pusd-student-ubuntu:1.14.0-csa . 
docker push nighthawkcoders/pusd-student-ubuntu:1.14.0-csa 
```
(replace 1.14.0-csa with the version you want to make, also the . is important so make sure you use it)
- important note: make sure to match the versions both in the commands as well as in the kasm_registry repo also for me it kept saying permission denied when pushing so try not using sudo if it says that after logging in.