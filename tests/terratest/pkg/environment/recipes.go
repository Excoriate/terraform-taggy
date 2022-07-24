package environment

import (
	"log"
	"os"
	"path/filepath"
	"testing"
)

const recipes = "terraform/examples"

func GetRecipeTerraformFolders(t *testing.T, recipes string) []string {
	var recipeFolders []string
	err := filepath.Walk(recipes, func(path string, info os.FileInfo, err error) error {
		if info.IsDir() && filepath.Base(path) == "recipe" {
			recipeFolders = append(recipeFolders, path)
		}
		return nil
	})

	if err != nil {
		t.Fatal("Cannot continue test. Failed to find recipes folders in path " + recipes + err.Error())
	}
	return nil
}

func getRootDir() string {
	wd, err := os.Getwd()
	if err != nil {
		log.Fatalf("Cannot continue test. Failed to get root directory %s", err.Error())
	}

	return filepath.Dir(filepath.Dir(wd))
}

func joinPathFromRootDir(toJoin string) (string, error) {
	rootDir := getRootDir()
	recipePath := filepath.Join(recipes, toJoin)
	fullPath := filepath.Join(rootDir, recipePath)

	_, err := os.Stat(fullPath)

	if !os.IsNotExist(err) {
		return fullPath, err
	}

	return "", err
}

func IsAValidTerraformModule(path string) bool {
	var tfFiles []string
	err := filepath.Walk(path, func(path string, info os.FileInfo, err error) error {
		if info.IsDir() {
			return nil
		}

		if filepath.Ext(path) == ".tf" || filepath.Ext(path) == ".hcl" {
			tfFiles = append(tfFiles, path)
		}

		return nil
	})

	if err != nil {
		log.Fatalf("Cannot continue test. Failed to find terraform files in path %s", err.Error())
		return false
	}

	return true
}

func RecipeFolderExistsAndReturn(t *testing.T, recipe string) string {
	recipeDir, err := joinPathFromRootDir(recipe)

	if err != nil {
		t.Fatalf("Recipe %s does not exist", recipe)
	}

	if !IsAValidTerraformModule(recipeDir) {
		t.Fatalf("Recipe %s does not contain a valid terraform module", recipe)
	}

	return recipeDir
}
