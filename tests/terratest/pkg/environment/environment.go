package environment

import (
	"github.com/gruntwork-io/terratest/modules/environment"
	"log"
	"os"
	"testing"
)

func envVar(t *testing.T, name string) string {
	return environment.GetFirstNonEmptyEnvVarOrFatal(t, []string{name})
}

func envVarOrDefault(t *testing.T, name string, defaultValue string) string {
	value := environment.GetFirstNonEmptyEnvVarOrEmptyString(t, []string{name})
	if value == "" {
		return defaultValue
	}

	return value
}

func GetRequiredEnvVariable(envName string) string {
	val, ok := os.LookupEnv(envName)
	if !ok {
		log.Fatalf("environment variable %s is not set. Stopping tests execution", envName)
	}
	return val
}
