# Attach volume to busybox

Attach a volume to the busybox which will be automatically deleted after leaving the container from it's shell.
Usefull if something is wrong with a file or needs to be changed.

```bash
kubectl run -i --rm --tty busybox --overrides='
{
    "apiVersion": "v1",
    "kind": "Pod",
    "spec": {
        "containers": [
            {
                "args": [
                    "sh"
                ],
                "image": "busybox",
                "imagePullPolicy": "Always",
                "name": "busybox",
                "stdin": true,
                "stdinOnce": true,
                "tty": true,
                "volumeMounts": [
                    {
                        "mountPath": "/data",
                        "name": "trendz-data"
                    }
                ],
                "priority": 0,
                "restartPolicy": "Never"
            }
        ],
        "volumes": [
            {
                "name": "trendz-data",
                "persistentVolumeClaim": {
                    "claimName": "trendz-data"
                }
            }
        ]
    }
}
' --image=busybox --restart=Never -- sh
```
