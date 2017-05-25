#import "AppIconViewController.h"
#import "AppIconCell.h"
#import "FAKIcon.h"
#import "FAKFontAwesome.h"

@interface AppIconViewController ()

@property (strong, nonatomic) NSArray *appIcons;

@end

@implementation AppIconViewController

- (void)awakeFromNib
{
    self.tabBarItem.image = [[FAKFontAwesome fivehundredpxIconWithSize:30] imageWithSize:CGSizeMake(30, 30)];
    self.tabBarItem.title = @"App Icons";
}

- (NSArray *)appIcons
{
    if (!_appIcons) {
        FAKFontAwesome *mailIcon = [FAKFontAwesome fivehundredpxIconWithSize:30];
        mailIcon.drawingBackgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mail-gradient"]];
        [mailIcon addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor]];
        
        FAKFontAwesome *musicIcon = [FAKFontAwesome fivehundredpxIconWithSize:30];
        musicIcon.drawingPositionAdjustment = UIOffsetMake(-3, 0);
        musicIcon.drawingBackgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"music-gradient"]];
        [musicIcon addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor]];
        
        FAKFontAwesome *phoneIcon = [FAKFontAwesome fivehundredpxIconWithSize:30];
        phoneIcon.drawingBackgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"phone-gradient"]];
        [phoneIcon addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor]];
        
        FAKFontAwesome *facetimeIcon = [FAKFontAwesome fivehundredpxIconWithSize:30];
        facetimeIcon.drawingBackgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"phone-gradient"]];
        [facetimeIcon addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor]];
        
        FAKFontAwesome *messageIcon = [FAKFontAwesome fivehundredpxIconWithSize:30];
        messageIcon.drawingPositionAdjustment = UIOffsetMake(0, -2);
        messageIcon.drawingBackgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"phone-gradient"]];
        [messageIcon addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor]];
        
        FAKFontAwesome *cameraIcon = [FAKFontAwesome fivehundredpxIconWithSize:30];
        cameraIcon.drawingBackgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"camera-gradient"]];
        [cameraIcon addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithWhite:0.1 alpha:1.0]];
        
        FAKFontAwesome *appstoreIcon = [FAKFontAwesome fivehundredpxIconWithSize:15];
        appstoreIcon.drawingPositionAdjustment = UIOffsetMake(0, -2);
        appstoreIcon.drawingBackgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"appstore-gradient"]];
        [appstoreIcon addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor]];

        _appIcons = @[mailIcon, musicIcon, phoneIcon, facetimeIcon, messageIcon, cameraIcon, appstoreIcon];
    }
    return _appIcons;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.appIcons count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AppIconCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AppIconCell" forIndexPath:indexPath];
    [cell configureCellWithIcon:self.appIcons[indexPath.row]];
    return cell;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
