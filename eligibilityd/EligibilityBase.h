//
//  EligibilityBase.h
//  eligibilityd
//
//  Created by Kyle on 2024/6/19.
//

#ifndef EligibilityBase_h
#define EligibilityBase_h

#define AreObjectsEqual(x, y) ({ \
    id _x = (x); \
    id _y = (y); \
    ((_x == nil && _y == nil) || (_x != nil && _y != nil && [_x isEqual:_y])); \
})

#endif /* EligibilityBase_h */
