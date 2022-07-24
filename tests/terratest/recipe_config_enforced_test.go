package terratest

import (
	"github.com/Excoriate/terraform-taggy/pkg/environment"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"testing"
)

func TestConfigEnforcedTest(t *testing.T) {
	t.Parallel()
	recipe := "recipe-config-enforced"

	targetModuleDir := environment.RecipeFolderExistsAndReturn(t, recipe)
	t.Logf("Target module is %s", targetModuleDir)

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: targetModuleDir,
		VarFiles:     []string{"config/terraform.tfvars"},
		NoColor:      true,
	})

	terraform.Init(t, terraformOptions)
	terraform.Plan(t, terraformOptions)
	terraform.Apply(t, terraformOptions)

	outputs := terraform.OutputAll(t, terraformOptions)

	// Assert that there is a key within the map[string]interface{} called "result"
	assert.Contains(t, outputs, "output_context")
	assert.Contains(t, outputs, "tags")

	tagsOutput := terraform.Output(t, terraformOptions, "tags")

	// Assert the tagsOutput has keys, and the map is not empty
	assert.NotEmpty(t, tagsOutput)
}
