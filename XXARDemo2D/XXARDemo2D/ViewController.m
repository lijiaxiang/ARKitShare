//
//  ViewController.m
//  XXARDemo2D
//
//  Created by XXViper on 2018/5/27.
//  Copyright © 2018年 XXViper. All rights reserved.
//

#import "ViewController.h"
#import "Scene.h"

@interface ViewController () <ARSKViewDelegate>

@property (nonatomic, strong) IBOutlet ARSKView *sceneView;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set the view's delegate
    //设置场景视图代理
    self.sceneView.delegate = self;
    
    // Show statistics such as fps and node count
    //显示帧率
    self.sceneView.showsFPS = YES;
    //显示界面节点（游戏开发中，一个角色对应一个节点）
    self.sceneView.showsNodeCount = YES;
    
    // Load the SKScene from 'Scene.sks'
    //加载2D场景（2D是平面的）
    Scene *scene = (Scene *)[SKScene nodeWithFileNamed:@"Scene"];
    
    // Present the scene
    //AR预览视图展现场景（这一点与3D视图加载有区别）
    [self.sceneView presentScene:scene];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Create a session configuration
    //创建设备追踪设置
    ARWorldTrackingConfiguration *configuration = [ARWorldTrackingConfiguration new];

    // Run the view's session
    //开始启动AR
    [self.sceneView.session runWithConfiguration:configuration];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // Pause the view's session
    //暂停
    [self.sceneView.session pause];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - ARSKViewDelegate

- (SKNode *)view:(ARSKView *)view nodeForAnchor:(ARAnchor *)anchor {
    // Create and configure a node for the anchor added to the view's session.
    //创建节点（节点可以理解为AR将要展示的2D图像）
    SKLabelNode *labelNode = [SKLabelNode labelNodeWithText:@"👾"];
    //显示在屏幕中心
    labelNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    labelNode.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    return labelNode;
}

- (void)session:(ARSession *)session didFailWithError:(NSError *)error {
    // Present an error message to the user
    
}

- (void)sessionWasInterrupted:(ARSession *)session {
    // Inform the user that the session has been interrupted, for example, by presenting an overlay
    
}

- (void)sessionInterruptionEnded:(ARSession *)session {
    // Reset tracking and/or remove existing anchors if consistent tracking is required
    
}

@end
