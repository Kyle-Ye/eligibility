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
    EligibilityDomainTypeNickel = 29,
    EligibilityDomainTypeCopper = 30,
    EligibilityDomainTypeZinc = 31,
    EligibilityDomainTypeGallium = 32,
    EligibilityDomainTypeGermanium = 33,
    EligibilityDomainTypeArsenic = 34,
    EligibilityDomainTypeSelenium = 35,
    EligibilityDomainTypeBromine = 36,
    EligibilityDomainTypeKrypton = 37,
    EligibilityDomainTypeRubidium = 38,
    EligibilityDomainTypeStrontium = 39,
    EligibilityDomainTypeYttrium = 40,
    EligibilityDomainTypeZirconium = 41,
    EligibilityDomainTypeNiobium = 42,
    EligibilityDomainTypeMolybdenum = 43,
    EligibilityDomainTypeTechnetium = 44,
    EligibilityDomainTypeRuthenium = 45,
    EligibilityDomainTypeRhodium = 46,
    EligibilityDomainTypePalladium = 47,
    EligibilityDomainTypeSilver = 48,
    EligibilityDomainTypeCadmium = 49,
    EligibilityDomainTypeIndium = 50,
    EligibilityDomainTypeTin = 51,
    EligibilityDomainTypeAntimony = 52,
    EligibilityDomainTypeTellurium = 53,
    EligibilityDomainTypeIodine = 54,
    EligibilityDomainTypeXenon = 55,
    EligibilityDomainTypeCesium = 56,
    EligibilityDomainTypeBarium = 57,
    EligibilityDomainTypeLanthanum = 58,
    EligibilityDomainTypeCerium = 59,
    EligibilityDomainTypePraseodymium = 60,
    EligibilityDomainTypeNeodymium = 61,
    EligibilityDomainTypePromethium = 62,
    EligibilityDomainTypeSamarium = 63,
    EligibilityDomainTypeEuropium = 64,
    EligibilityDomainTypeGadolinium = 65,
    EligibilityDomainTypeTerbium = 66,
    EligibilityDomainTypeDysprosium = 67,
    EligibilityDomainTypeHolmium = 68,
    EligibilityDomainTypeErbium = 69,
    EligibilityDomainTypeThulium = 70,
    EligibilityDomainTypeYtterbium = 71,
    EligibilityDomainTypeLutetium = 72,
    EligibilityDomainTypeHafnium = 73,
    EligibilityDomainTypeTantalum = 74,
    EligibilityDomainTypeTungsten = 75,
    EligibilityDomainTypeRhenium = 76,
    EligibilityDomainTypeOsmium = 77,
    EligibilityDomainTypeIridium = 78,
    EligibilityDomainTypePlatinum = 79,
    EligibilityDomainTypeGold = 80,
    EligibilityDomainTypeMercury = 81,
    EligibilityDomainTypeThallium = 82,
    EligibilityDomainTypeLead = 83,
    EligibilityDomainTypeBismuth = 84,
    EligibilityDomainTypePolonium = 85,
    EligibilityDomainTypeAstatine = 86,
    EligibilityDomainTypeRadon = 87,
    EligibilityDomainTypeFrancium = 88,
    EligibilityDomainTypeRadium = 89,
    EligibilityDomainTypeActinium = 90,
    EligibilityDomainTypeThorium = 91,
    EligibilityDomainTypeProtactinium = 92,
    EligibilityDomainTypeUranium = 93,
    EligibilityDomainTypeNeptunium = 94,
    EligibilityDomainTypePlutonium = 95,
    EligibilityDomainTypeAmericium = 96,
    EligibilityDomainTypeCurium = 97,
    EligibilityDomainTypeBerkelium = 98,
    EligibilityDomainTypeCalifornium = 99,
    EligibilityDomainTypeEinsteinium = 100,
    EligibilityDomainTypeFermium = 101,
    EligibilityDomainTypeMendelevium = 102,
    EligibilityDomainTypeNobelium = 103,
    EligibilityDomainTypeLawrencium = 104,
    EligibilityDomainTypeRutherfordium = 105,
    EligibilityDomainTypeDubnium = 106,
    EligibilityDomainTypeSeaborgium = 107,
    EligibilityDomainTypeBohrium = 108,
    EligibilityDomainTypeHassium = 109,
    EligibilityDomainTypeMeitnerium = 110,
    EligibilityDomainTypeDarmstadtium = 111,
    EligibilityDomainTypeRoentgenium = 112,
    EligibilityDomainTypeCopernicium = 113,
    EligibilityDomainTypeNihonium = 114,
    EligibilityDomainTypeFlerovium = 115,
    EligibilityDomainTypeMoscovium = 116,
    EligibilityDomainTypeLivermorium = 117,
    EligibilityDomainTypeTennessine = 118,
    EligibilityDomainTypeOganesson = 119,
    EligibilityDomainTypeTest = 120,
    /// Enables machine learning transcripts of podcasts
    EligibilityDomainTypePodcastsTranscripts = 121,
    /// Apple Intelligence
    EligibilityDomainTypeGreymatter = 122,
    /// Xcode Predictive Code Completion
    EligibilityDomainTypeXcodeLLM = 123,
    EligibilityDomainTypeSearchMarketplaces = 124,
};

const char *eligibility_domain_to_str(EligibilityDomainType domain);

#endif /* EligibilityDomainType_h */
