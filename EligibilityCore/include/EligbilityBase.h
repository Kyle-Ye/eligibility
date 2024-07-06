//
//  EligbilityBase.h
//  EligibilityCore
//
//  Created by Kyle on 2024/6/18.
//  Audited for RELEASE_2024_BETA_1
//  Status: Complete

#ifndef EligbilityBase_h
#define EligbilityBase_h

#include <sys/cdefs.h>

#ifndef __has_builtin
#define __has_builtin(x) 0
#endif
#ifndef __has_include
#define __has_include(x) 0
#endif
#ifndef __has_feature
#define __has_feature(x) 0
#endif
#ifndef __has_attribute
#define __has_attribute(x) 0
#endif
#ifndef __has_extension
#define __has_extension(x) 0
#endif

#if __GNUC__
#define ELIGIBILITY_NORETURN __attribute__((__noreturn__))
#define ELIGIBILITY_NOTHROW __attribute__((__nothrow__))
#define ELIGIBILITY_NONNULL1 __attribute__((__nonnull__(1)))
#define ELIGIBILITY_NONNULL2 __attribute__((__nonnull__(2)))
#define ELIGIBILITY_NONNULL3 __attribute__((__nonnull__(3)))
#define ELIGIBILITY_NONNULL4 __attribute__((__nonnull__(4)))
#define ELIGIBILITY_NONNULL5 __attribute__((__nonnull__(5)))
#define ELIGIBILITY_NONNULL6 __attribute__((__nonnull__(6)))
#define ELIGIBILITY_NONNULL7 __attribute__((__nonnull__(7)))
#define ELIGIBILITY_NONNULL8 __attribute__((__nonnull__(8)))
#define ELIGIBILITY_NONNULL9 __attribute__((__nonnull__(9)))
#define ELIGIBILITY_NONNULL10 __attribute__((__nonnull__(10)))
#define ELIGIBILITY_NONNULL11 __attribute__((__nonnull__(11)))
#define ELIGIBILITY_NONNULL12 __attribute__((__nonnull__(12)))
#define ELIGIBILITY_NONNULL13 __attribute__((__nonnull__(13)))
#define ELIGIBILITY_NONNULL14 __attribute__((__nonnull__(14)))
#define ELIGIBILITY_NONNULL15 __attribute__((__nonnull__(15)))
#define ELIGIBILITY_NONNULL_ALL __attribute__((__nonnull__))
#define ELIGIBILITY_SENTINEL __attribute__((__sentinel__))
#define ELIGIBILITY_PURE __attribute__((__pure__))
#define ELIGIBILITY_CONST __attribute__((__const__))
#define ELIGIBILITY_WARN_RESULT __attribute__((__warn_unused_result__))
#define ELIGIBILITY_MALLOC __attribute__((__malloc__))
#define ELIGIBILITY_USED __attribute__((__used__))
#define ELIGIBILITY_UNUSED __attribute__((__unused__))
#define ELIGIBILITY_COLD __attribute__((__cold__))
#define ELIGIBILITY_WEAK __attribute__((__weak__))
#define ELIGIBILITY_WEAK_IMPORT __attribute__((__weak_import__))
#define ELIGIBILITY_NOINLINE __attribute__((__noinline__))
#define ELIGIBILITY_ALWAYS_INLINE __attribute__((__always_inline__))
#define ELIGIBILITY_TRANSPARENT_UNION __attribute__((__transparent_union__))
#define ELIGIBILITY_ALIGNED(n) __attribute__((__aligned__((n))))
#define ELIGIBILITY_FORMAT_PRINTF(x, y) __attribute__((__format__(printf,x,y)))
#define ELIGIBILITY_EXPORT extern __attribute__((__visibility__("default")))
#define ELIGIBILITY_INLINE static __inline__
#define ELIGIBILITY_EXPECT(x, v) __builtin_expect((x), (v))
#else
#define ELIGIBILITY_NORETURN
#define ELIGIBILITY_NOTHROW
#define ELIGIBILITY_NONNULL1
#define ELIGIBILITY_NONNULL2
#define ELIGIBILITY_NONNULL3
#define ELIGIBILITY_NONNULL4
#define ELIGIBILITY_NONNULL5
#define ELIGIBILITY_NONNULL6
#define ELIGIBILITY_NONNULL7
#define ELIGIBILITY_NONNULL8
#define ELIGIBILITY_NONNULL9
#define ELIGIBILITY_NONNULL10
#define ELIGIBILITY_NONNULL11
#define ELIGIBILITY_NONNULL12
#define ELIGIBILITY_NONNULL13
#define ELIGIBILITY_NONNULL14
#define ELIGIBILITY_NONNULL15
#define ELIGIBILITY_NONNULL_ALL
#define ELIGIBILITY_SENTINEL
#define ELIGIBILITY_PURE
#define ELIGIBILITY_CONST
#define ELIGIBILITY_WARN_RESULT
#define ELIGIBILITY_MALLOC
#define ELIGIBILITY_USED
#define ELIGIBILITY_UNUSED
#define ELIGIBILITY_COLD
#define ELIGIBILITY_WEAK
#define ELIGIBILITY_WEAK_IMPORT
#define ELIGIBILITY_NOINLINE
#define ELIGIBILITY_ALWAYS_INLINE
#define ELIGIBILITY_TRANSPARENT_UNION
#define ELIGIBILITY_ALIGNED(n)
#define ELIGIBILITY_FORMAT_PRINTF(x, y)
#define ELIGIBILITY_EXPORT extern
#define ELIGIBILITY_INLINE static inline
#define ELIGIBILITY_EXPECT(x, v) (x)
#endif

#if __has_attribute(noescape)
#define ELIGIBILITY_NOESCAPE __attribute__((__noescape__))
#else
#define ELIGIBILITY_NOESCAPE
#endif

#if defined(__cplusplus) && defined(__clang__)
#define ELIGIBILITY_FALLTHROUGH [[clang::fallthrough]]
#elif __has_attribute(fallthrough)
#define ELIGIBILITY_FALLTHROUGH __attribute__((__fallthrough__))
#else
#define ELIGIBILITY_FALLTHROUGH
#endif

#if __has_feature(assume_nonnull)
#define ELIGIBILITY_ASSUME_NONNULL_BEGIN _Pragma("clang assume_nonnull begin")
#define ELIGIBILITY_ASSUME_NONNULL_END   _Pragma("clang assume_nonnull end")
#else
#define ELIGIBILITY_ASSUME_NONNULL_BEGIN
#define ELIGIBILITY_ASSUME_NONNULL_END
#endif

#if __has_builtin(__builtin_assume)
#define ELIGIBILITY_COMPILER_CAN_ASSUME(expr) __builtin_assume(expr)
#else
#define ELIGIBILITY_COMPILER_CAN_ASSUME(expr) ((void)(expr))
#endif

#if __has_extension(attribute_overloadable)
#define ELIGIBILITY_OVERLOADABLE __attribute__((__overloadable__))
#else
#define ELIGIBILITY_OVERLOADABLE
#endif

#if __has_attribute(analyzer_suppress)
#define ELIGIBILITY_ANALYZER_SUPPRESS(RADAR) __attribute__((analyzer_suppress))
#else
#define ELIGIBILITY_ANALYZER_SUPPRESS(RADAR)
#endif

#include <CoreFoundation/CoreFoundation.h>
#define ELIGIBILITY_ENUM CF_ENUM
#define ELIGIBILITY_CLOSED_ENUM CF_CLOSED_ENUM
#define ELIGIBILITY_OPTIONS CF_OPTIONS
#define ELIGIBILITY_CLOSED_OPTIONS CF_CLOSED_OPTIONS

#if __has_feature(attribute_availability_swift)
// equivalent to __SWIFT_UNAVAILABLE from Availability.h
#define ELIGIBILITY_SWIFT_UNAVAILABLE(_msg) \
    __attribute__((__availability__(swift, unavailable, message=_msg)))
#else
#define ELIGIBILITY_SWIFT_UNAVAILABLE(_msg)
#endif

#if __has_attribute(__swift_attr__)
#define ELIGIBILITY_SWIFT_UNAVAILABLE_FROM_ASYNC(msg) \
    __attribute__((__swift_attr__("@_unavailableFromAsync(message: \"" msg "\")")))
#else
#define ELIGIBILITY_SWIFT_UNAVAILABLE_FROM_ASYNC(msg)
#endif

#if __has_attribute(swift_private)
# define ELIGIBILITY_REFINED_FOR_SWIFT __attribute__((__swift_private__))
#else
# define ELIGIBILITY_REFINED_FOR_SWIFT
#endif

#if __has_attribute(swift_name)
# define ELIGIBILITY_SWIFT_NAME(_name) __attribute__((__swift_name__(#_name)))
#else
# define ELIGIBILITY_SWIFT_NAME(_name)
#endif

#define __ELIGIBILITY_STRINGIFY(s) #s
#define ELIGIBILITY_STRINGIFY(s) __ELIGIBILITY_STRINGIFY(s)
#define __ELIGIBILITY_CONCAT(x, y) x ## y
#define ELIGIBILITY_CONCAT(x, y) __ELIGIBILITY_CONCAT(x, y)

#ifdef __GNUC__
#define eligibility_prevent_tail_call_optimization()  __asm__("")
#define eligibility_is_compile_time_constant(expr)    __builtin_constant_p(expr)
#define eligibility_compiler_barrier()                __asm__ __volatile__("" ::: "memory")
#else
#define eligibility_prevent_tail_call_optimization()  do { } while (0)
#define eligibility_is_compile_time_constant(expr)    0
#define eligibility_compiler_barrier()                do { } while (0)
#endif

#if __has_attribute(not_tail_called)
#define ELIGIBILITY_NOT_TAIL_CALLED __attribute__((__not_tail_called__))
#else
#define ELIGIBILITY_NOT_TAIL_CALLED
#endif


typedef void (*eligibility_function_t)(void *_Nullable);

#ifdef __BLOCKS__
/*!
 * @typedef eligibility_block_t
 *
 * @abstract
 * Generic type for a block taking no arguments and returning no value.
 *
 * @discussion
 * When not building with Objective-C ARC, a block object allocated on or
 * copied to the heap must be released with a -[release] message or the
 * Block_release() function.
 *
 * The declaration of a block literal allocates storage on the stack.
 * Therefore, this is an invalid construct:
 * <code>
 * eligibility_block_t block;
 * if (x) {
 *     block = ^{ printf("true\n"); };
 * } else {
 *     block = ^{ printf("false\n"); };
 * }
 * block(); // unsafe!!!
 * </code>
 *
 * What is happening behind the scenes:
 * <code>
 * if (x) {
 *     struct Block __tmp_1 = ...; // setup details
 *     block = &__tmp_1;
 * } else {
 *     struct Block __tmp_2 = ...; // setup details
 *     block = &__tmp_2;
 * }
 * </code>
 *
 * As the example demonstrates, the address of a stack variable is escaping the
 * scope in which it is allocated. That is a classic C bug.
 *
 * Instead, the block literal must be copied to the heap with the Block_copy()
 * function or by sending it a -[copy] message.
 */
typedef void (^eligibility_block_t)(void);
#endif



#define ELIGIBILITY_ASSUME_PTR_ABI_SINGLE_BEGIN __ASSUME_PTR_ABI_SINGLE_BEGIN
#define ELIGIBILITY_ASSUME_PTR_ABI_SINGLE_END __ASSUME_PTR_ABI_SINGLE_END
#define ELIGIBILITY_UNSAFE_INDEXABLE __unsafe_indexable
#define ELIGIBILITY_HEADER_INDEXABLE __header_indexable
#define ELIGIBILITY_COUNTED_BY(N) __counted_by(N)
#define ELIGIBILITY_SIZED_BY(N) __sized_by(N)

#endif /* EligbilityBase_h */
