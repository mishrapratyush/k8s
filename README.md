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


## Running app on local Kubernetes
1. Create a deployment manifest: (dev-k8s.yml)
2. Run following Kubectl commands:
    1.  kubectl apply -f .\dev-k8s.yml
    2.  kubectl get deployments
    3.  kubectl get pods
    4.  kubectl describe pod messageapi-<id>
    If you see image not found error then edit the deployment
    5. kubectl edit deployment messageapi
    6. update the notepad: set imagePullPolicy to "IfNotPresent"
    7. check rollout status - 

3. local k8s web dashboard: http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/
    1.  if it doesnt open run kubectl proxy
    See following url for more details: https://kubernetes.io/blog/2020/05/21/wsl-docker-kubernetes-on-the-windows-desktop/
    2.  **NOTE:** You may have to run kubectl apply -f dashboard-adminuser.yml file to create a local admin user for the dashboard that will needed to authenticate to the dashboard

4. generate token: kubectl -n kubernetes-dashboard get secret $(kubectl -n kubernetes-dashboard get sa/admin-user -o jsonpath="{.secrets[0].name}") -o go-template="{{.data.token | base64decode}}"