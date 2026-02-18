package testimpl

import (
	"context"

	"testing"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/service/lambda"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/launchbynttdata/lcaf-component-terratest/types"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

func TestComposableComplete(t *testing.T, ctx types.TestContext) {
	lambdaClient := GetAWSLambdaClient(t)
	opts := ctx.TerratestTerraformOptions()

	functionArns := terraform.OutputMap(t, opts, "lambda_function_arns")
	functionNames := terraform.OutputMap(t, opts, "lambda_function_names")
	// functionNames are the actual Lambda names (from lambda_function_name_overrides when provided, else resource_names-generated)

	t.Run("TestLambdaFunctionExists", func(t *testing.T) {
		for key, functionName := range functionNames {
			function, err := lambdaClient.GetFunction(context.TODO(), &lambda.GetFunctionInput{
				FunctionName: &functionName,
			})
			require.NoError(t, err, "GetFunction failed for %q (name: %s)", key, functionName)
			expectedARN := functionArns[key]
			require.NotEmpty(t, expectedARN, "no expected ARN for key %q", key)
			assert.Equal(t, expectedARN, *function.Configuration.FunctionArn, "Expected ARN did not match actual ARN for key %q", key)
			assert.Equal(t, functionName, *function.Configuration.FunctionName, "Expected Name did not match actual Name for key %q", key)
		}
	})

	t.Run("TestLambdaFunctionNameOverrides", func(t *testing.T) {
		overrides := terraform.OutputMap(t, opts, "lambda_function_name_overrides")
		if len(overrides) == 0 {
			t.Skip("lambda_function_name_overrides not set or empty; skipping override assertion")
		}
		for key, overrideName := range overrides {
			outputName, ok := functionNames[key]
			require.True(t, ok, "lambda_function_names missing key %q", key)
			assert.Equal(t, overrideName, outputName, "lambda_function_names[%q] should equal override value", key)
			function, err := lambdaClient.GetFunction(context.TODO(), &lambda.GetFunctionInput{
				FunctionName: &overrideName,
			})
			require.NoError(t, err, "GetFunction failed for override name %q (key: %s)", overrideName, key)
			assert.Equal(t, overrideName, *function.Configuration.FunctionName, "AWS Lambda name should match override for key %q", key)
		}
	})
}

func GetAWSLambdaClient(t *testing.T) *lambda.Client {
	awsLambdaClient := lambda.NewFromConfig(GetAWSConfig(t))
	return awsLambdaClient
}

func GetAWSConfig(t *testing.T) (cfg aws.Config) {
	cfg, err := config.LoadDefaultConfig(context.TODO())
	require.NoErrorf(t, err, "unable to load SDK config, %v", err)
	return cfg
}
