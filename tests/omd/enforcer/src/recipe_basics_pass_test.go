package test

import (
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"testing"
)

func TestRecipeBasicPass(t *testing.T) {
	t.Parallel()

	terraformOptions := &terraform.Options{
		TerraformDir: "../../../../terraform/examples/aws/recipe-basic-validations",
		Upgrade:      false,
		VarFiles:     []string{"config/fixtures_default_rules_pass.tfvars"},
		Vars: map[string]interface{}{
			"is_enabled": true,
		},
	}

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	outputs := terraform.OutputAll(t, terraformOptions)
	result := outputs["result"]

	t.Logf("result: %s", result)

	assert.NotNil(t, outputs)
	assert.Equal(t, 1, len(outputs))
	assert.Equal(t, result, outputs["result"])
}
