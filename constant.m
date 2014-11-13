#import "constant.h"

@implementation constant

NSString *const S3KeyName = @"upload1.txt";

NSString *const S3BucketName = @"isaactest";

//All the data below is same as the AppDelegate.m , i just try to put it in other parts as a reference.

NSString *const AWSAccountID = @"XXXXX";
NSString *const CognitoPoolID = @"us-east-1:dXXXXXXXXXXXX";
NSString *const CognitoRoleAuth = @"arn:aws:iam::XXXXXXXXXX:role/Cognito_CognitoTestingAuth_DefaultRole";
NSString *const CognitoRoleUnauth = @"arn:aws:iam::XXXXXXXXXX:role/Cognito_CognitoTestingUnauth_DefaultRole";



@end
