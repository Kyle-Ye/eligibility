//
//  EligibilityDefine.h
//  eligibilityd
//
//  Created by Kyle on 2024/6/19.
//

#ifndef EligibilityDefine_h
#define EligibilityDefine_h

#define VERSION "98.0.0.0.5"

#define AreObjectsEqual(x, y) ({ \
    id _x = (x); \
    id _y = (y); \
    ((_x == nil && _y == nil) || (_x != nil && _y != nil && [_x isEqual:_y])); \
})

#endif /* EligibilityDefine_h */
