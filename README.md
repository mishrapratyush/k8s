# Getting started with Azure Kubernetes
This repo has code and instructions on how to containerize an app and deploy it to Azure K8s cluster

## Setting up environment
Follow this tutorial on setting up **VSCode on Windows** for Python/Flask: https://github.com/microsoft/python-sample-vscode-flask-tutorial/tree/tutorial

```
PS C:\k8s\repo> python -m venv env
PS C:\k8s\repo> .\env\Scripts\activate
(env) PS C:\k8s\repo> pip install flask
```

To run your flask app, ensure you have the right path set in the launch.json file and Flask is selected for run option.

```
"env": {
                "FLASK_APP": "api/app.py",
                "FLASK_ENV": "development",
                "FLASK_DEBUG": "0"
            },
```
![Alt text](docImages/launch_json.png?raw=true "Launch.json")

### Running on WSL2
If you want to run Python on Linux (WSL2 running on windows) then add these steps:
1. Mount the file system (windows) where the project code is

```
pratyush@pmishra-SB:/mnt/c/Users/pmishra$ cd /mnt/c/k8s/repo
```

2. Create a virtual environment and activate the virtual environment

```
pratyush@pmishra-SB:/mnt/c/k8s/repo$ python3 -m venv env
pratyush@pmishra-SB:/mnt/c/k8s/repo$ source env/bin/activate
```

3. Launch Visual Studio Code
``` 
pratyush@pmishra-SB:/mnt/c/k8s/repo$ code .
```

## Dockerizing your app
**Note:** 
1. Name the docker file as "Dockerfile" no extensions **case does matter**
2. gunicorn requires module name seperated by "." not "/". See example below:

```
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "api.app:app"]
```

Follow this tutorial to add support for docker to your app: https://code.visualstudio.com/docs/containers/quickstart-python