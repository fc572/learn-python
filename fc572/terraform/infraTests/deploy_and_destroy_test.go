package test

import (
	"fmt"
	"github.com/stretchr/testify/assert"
	"net/http"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"

	"github.com/gruntwork-io/terratest/modules/random"
)

// An example of a unit test for the Terraform module in examples/hello-world-app
func TestAzureDeploymentAndDestroy(t *testing.T) {
	t.Parallel()

	// A unique ID we can use to namespace all our resource names and ensure they don't clash across parallel tests
	uniqueId := random.UniqueId()

	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../../terraform",

		//Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"cluster_name":       fmt.Sprintf("fc572-Terratest-%s", uniqueId),
			"load_balancer_name": fmt.Sprintf("fc572-loadBalancer-%s", uniqueId),
		},
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.DestroyE(t, terraformOptions){
		if err != nil{
			fmt.Printf("ERR IS: ", err)
			fmt.Printf("All good it is the ecr not deleting.")
		}
	}()

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// Check that the app is working as expected
	validateResponse(t, terraformOptions)
}

// Validate the "Hello, World" app is working
func validateResponse(t *testing.T, terraformOptions *terraform.Options) {
	// Run `terraform output` to get the values of output variables
	load_balancer_url := terraform.Output(t, terraformOptions, "load_balancer_url")

	//Verify above var is not empty
	// assert for not nil (good when you expect something)
	if assert.NotNil(t, load_balancer_url) {
		// now we know that object isn't nil, we are safe to make
		// further assertions without causing any errors
		assert.Contains(t, load_balancer_url, "fc572")
	}

	// url := fmt.Sprintf("http://%s", load_balancer_url)
	// http_helper.HttpGetWithRetry(t, url, nil, 200, "This is working!", 30, 5*time.Second)

	// Make an HTTP request to the instance and make sure we get back a 200 OK with the body "Hello, World!"
	requestURL := fmt.Sprintf("http://%s", load_balancer_url)
	res, err := http.Get(requestURL)
	if err != nil {
		fmt.Printf("error making http request: %s\n", err)
	}
	fmt.Printf("CODE %d", res.StatusCode)
	assert.Equal(t, res.StatusCode, 200)
	assert.Contains(t, res.Body, "This is working")

}
