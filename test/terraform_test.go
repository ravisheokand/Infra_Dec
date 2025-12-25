package test

import (
    "testing"
    "os"
    "github.com/gruntwork-io/terratest/modules/terraform"
)

func TestTerraformExample(t *testing.T) {
    t.Parallel() // Run tests in parallel

    terraformOptions := &terraform.Options{
        // Path to Terraform code
        TerraformDir: "../",

        // Variables to pass to Terraform
        Vars: map[string]interface{}{
            "example_variable": "value",
        },

        // Disable colors in Terraform commands for easier parsing
        NoColor: true,
    }

    // Clean up resources with "terraform destroy" at the end of the test
    defer terraform.Destroy(t, terraformOptions)

    // Run "terraform init" and "terraform apply"
    terraform.InitAndApply(t, terraformOptions)

    // Run "terraform output" and check value
    exampleOutput := terraform.Output(t, terraformOptions, "example_output")
    if exampleOutput != "expected_value" {
        t.Fatalf("Expected output to be 'expected_value' but got %s", exampleOutput)
    }
}
