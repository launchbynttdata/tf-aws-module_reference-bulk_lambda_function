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

	functionArns := terraform.OutputMap(t, ctx.TerratestTerraformOptions(), "lambda_function_arns")
	functionNames := terraform.OutputMap(t, ctx.TerratestTerraformOptions(), "lambda_function_names")

	t.Run("TestLambdaFunctionExists", func(t *testing.T) {
		for _, functionName := range functionNames {
			function, err := lambdaClient.GetFunction(context.TODO(), &lambda.GetFunctionInput{
				FunctionName: &functionName,
			})
			if err != nil {
				t.Errorf("Failure during GetFunction: %v", err)
			}
			assert.Equal(t, *function.Configuration.FunctionArn, functionArns[functionName], "Expected ARN did not match actual ARN!")
			assert.Equal(t, *function.Configuration.FunctionName, functionName, "Expected Name did not match actual Name!")
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
