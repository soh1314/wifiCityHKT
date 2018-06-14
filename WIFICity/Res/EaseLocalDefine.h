

#ifndef EaseLocalDefine_h
#define EaseLocalDefine_h

#define iPhoneX_BOTTOM_HEIGHT  ([UIScreen mainScreen].bounds.size.height==812?34:0)

#define NSEaseLocalizedString(key, comment) [[NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:@"EaseUIResource" withExtension:@"bundle"]] localizedStringForKey:(key) value:@"" table:nil]

#endif /* EaseLocalDefine_h */
