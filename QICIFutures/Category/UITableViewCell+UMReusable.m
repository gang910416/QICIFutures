
#import "UITableViewCell+UMReusable.h"

@implementation UITableViewCell (UMReusable)

+ (instancetype)um_cellWithTableView:(UITableView *)tableView {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self.class)];
    if (!cell) {
        NSString *path = [[NSBundle mainBundle] pathForResource:NSStringFromClass(self.class) ofType:@"nib"];
        if (path.length) {
            cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:nil options:nil] firstObject];
            [cell setValue:NSStringFromClass(self.class) forKey:@"reuseIdentifier"];
        } else {
            cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(self.class)];
        }
    }
    return cell;
}
@end
