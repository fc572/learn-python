#Login
aws ecr get-login-password --region eu-west-2 | podman login --username AWS --password-stdin 045741104708.dkr.ecr.eu-west-2.amazonaws.com
#evaluate image id
IMAGE_ID=$(podman images thisworks:01 -q)
#tag image to latest
podman tag ${IMAGE_ID} 045741104708.dkr.ecr.eu-west-2.amazonaws.com/fc572-ecr-repo-tb-deleted:latest
#push image to ecr
podman push 045741104708.dkr.ecr.eu-west-2.amazonaws.com/fc572-ecr-repo-tb-deleted:latest
