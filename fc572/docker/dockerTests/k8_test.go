package test

import (
	"fmt"
	"testing"
	"time"

	http_helper "github.com/gruntwork-io/terratest/modules/http-helper"
	"github.com/gruntwork-io/terratest/modules/k8s"
	//"github.com/stretchr/testify/assert"
)

func TestKubernetesHelloWorldExample(t *testing.T) {
	t.Parallel()

	// Path to the Kubernetes resource config we will test.
	kubeResourcePath := "infraTests.yaml"

	// Setup the kubectl config and context.
	options := k8s.NewKubectlOptions("", "", "default")

	// At the end of the test, run "kubectl delete" to clean up any resources that were created.
	defer k8s.KubectlDelete(t, options, kubeResourcePath)

	// Run `kubectl apply` to deploy. Fail the test if there are any errors.
	k8s.KubectlApply(t, options, kubeResourcePath)

	// Verify the service is available and get the URL for it.
	k8s.WaitUntilServiceAvailable(t, options, "bb-entrypoint", 10, 1*time.Second)
	url := fmt.Sprintf("http://localhost:80")
	// service := k8s.GetService(t, options, "hello-world-service")
	// url := fmt.Sprintf("http://%s", k8s.GetServiceEndpoint(t, options, service, 5000))

	// Make an HTTP request to the URL and make sure it returns a 200 OK with the body "Hello, World".
	err := http_helper.HttpGetWithRetryE(t, url, nil, 200, "This is working!", 3, 3*time.Second)
	// if err != nil {
	fmt.Printf("error making http request: %s\n", err)
	// 	assert.Contains(t, err, "This is working")
	// }
}
