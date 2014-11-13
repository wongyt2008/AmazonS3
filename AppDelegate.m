#import "AppDelegate.h"
#import <AWSiOSSDKv2/S3.h>
#import "constant.h"
@interface AppDelegate ()

@end

@implementation AppDelegate




- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    
    AWSCognitoCredentialsProvider *credentialsProvider = [AWSCognitoCredentialsProvider
                                                          credentialsWithRegionType:AWSRegionUSEast1
                                                          accountId:@"613437952972"
                                                          identityPoolId:@"us-east-1:d2487b94-d010-4c5d-b245-8eebd46bc300"
                                                          unauthRoleArn:@"arn:aws:iam::613437952972:role/Cognito_CognitoTestingUnauth_DefaultRole"
                                                          authRoleArn:@"arn:aws:iam::613437952972:role/Cognito_CognitoTestingAuth_DefaultRole"];
    
    AWSServiceConfiguration *configuration = [AWSServiceConfiguration configurationWithRegion:AWSRegionUSEast1
                                                                          credentialsProvider:credentialsProvider];
    
    [AWSServiceManager defaultServiceManager].defaultServiceConfiguration = configuration;
    
    

    
    
    [[credentialsProvider getIdentityId] continueWithSuccessBlock:^id(BFTask *task){
        NSString* cognitoId = credentialsProvider.identityId;
        NSLog(@"cognitoId: %@", cognitoId);
        //[self launchCount];
        return nil;
    }];

 

    

    
    
    
    
    
    return YES;
}
