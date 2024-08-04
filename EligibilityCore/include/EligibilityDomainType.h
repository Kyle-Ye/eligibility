//
//  EligibilityDomainType.h
//  EligibilityCore
//
//  Created by Kyle on 2024/6/24.
//

#ifndef EligibilityDomainType_h
#define EligibilityDomainType_h

#include "EligibilityBase.h"

#define EligibilityDomainTypeCount 124

// Documentation Source from: https://theapplewiki.com/wiki/Eligibility
typedef ELIGIBILITY_ENUM(uint64_t, EligibilityDomainType) {
    EligibilityDomainTypeInvalid = 0,
    EligibilityDomainTypeLotX = 1,
    /// Install marketplace-distributed apps
    EligibilityDomainTypeHydrogen = 2,
    /// Update/restore marketplace-distributed apps
    EligibilityDomainTypeHelium = 3,
    /// Update/restore web browser engine host apps
    EligibilityDomainTypeLithium = 4,
    /// Disabling Home Screen Web Apps
    EligibilityDomainTypeBeryllium = 5,
    /// Update/restore embedded web engine apps
    EligibilityDomainTypeBoron = 6,
    /// Install web browser engine host apps
    EligibilityDomainTypeCarbon = 7,
    /// Web browser choice prompt on first launch of Safari
    EligibilityDomainTypeNitrogen = 8,
    EligibilityDomainTypeOxygen = 9,
    EligibilityDomainTypeFluorine = 10,
    EligibilityDomainTypeNeon = 11,
    /// Contactless payment apps can use host card emulation (HCE)
    EligibilityDomainTypeSodium = 12,
    EligibilityDomainTypeMagnesium = 13,
    /// Contactless payment apps can become default (opens on double-clicking side button)
    EligibilityDomainTypeAluminum = 14,
    /// Default contactless payment apps can be used
    EligibilityDomainTypeSilicon = 15,
    /// Apps permitted to use external purchase links
    EligibilityDomainTypePhosphorus = 16,
    /// Apps permitted to use approved third-party billing
    EligibilityDomainTypeSulfur = 17,
    /// Device and app analytics
    EligibilityDomainTypeChlorine = 18,
    /// Install apps distributed via the web
    EligibilityDomainTypeArgon = 19,
    /// Update/restore apps distributed via the web
    EligibilityDomainTypePotassium = 20,
    /// Adds "(China)" suffix to Hong Kong, Macao, and Taiwan
    EligibilityDomainTypeCalcium = 21,
    EligibilityDomainTypeScandium = 22,
    /// Install embedded web engine apps
    EligibilityDomainTypeTitanium = 23,
    EligibilityDomainTypeVanadium = 24,
    EligibilityDomainTypeChromium = 25,
    EligibilityDomainTypeManganese = 26,
    /// iPhone Mirroring
    EligibilityDomainTypeIron = 27,
    EligibilityDomainTypeCobalt = 28,
    EligibilityDomainTypeTest = 120,
    /// Enables machine learning transcripts of podcasts
    EligibilityDomainTypePodcastsTranscripts = 121,
    /// Apple Intelligence
    EligibilityDomainTypeGreymatter = 122,
    /// Xcode Predictive Code Completion
    EligibilityDomainTypeXcodeLLM = 123,
};

#endif /* EligibilityDomainType_h */
