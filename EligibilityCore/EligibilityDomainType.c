//
//  EligibilityDomainType.c
//  eligibility
//
//  Created by Kyle on 2024/8/5.
//

#include "EligibilityDomainType.h"

const char *eligibility_domain_to_str(EligibilityDomainType domain) {
    switch (domain) {
        case EligibilityDomainTypeInvalid: return "OS_ELIGIBILITY_DOMAIN_INVALID";
        case EligibilityDomainTypeLotX: return "OS_ELIGIBILITY_DOMAIN_LOTX";
        case EligibilityDomainTypeHydrogen: return "OS_ELIGIBILITY_DOMAIN_HYDROGEN";
        case EligibilityDomainTypeHelium: return "OS_ELIGIBILITY_DOMAIN_HELIUM";
        case EligibilityDomainTypeLithium: return "OS_ELIGIBILITY_DOMAIN_LITHIUM";
        case EligibilityDomainTypeBeryllium: return "OS_ELIGIBILITY_DOMAIN_BERYLLIUM";
        case EligibilityDomainTypeBoron: return "OS_ELIGIBILITY_DOMAIN_BORON";
        case EligibilityDomainTypeCarbon: return "OS_ELIGIBILITY_DOMAIN_CARBON";
        case EligibilityDomainTypeNitrogen: return "OS_ELIGIBILITY_DOMAIN_NITROGEN";
        case EligibilityDomainTypeOxygen: return "OS_ELIGIBILITY_DOMAIN_OXYGEN";
        case EligibilityDomainTypeFluorine: return "OS_ELIGIBILITY_DOMAIN_FLUORINE";
        case EligibilityDomainTypeNeon: return "OS_ELIGIBILITY_DOMAIN_NEON";
        case EligibilityDomainTypeSodium: return "OS_ELIGIBILITY_DOMAIN_SODIUM";
        case EligibilityDomainTypeMagnesium: return "OS_ELIGIBILITY_DOMAIN_MAGNESIUM";
        case EligibilityDomainTypeAluminum: return "OS_ELIGIBILITY_DOMAIN_ALUMINUM";
        case EligibilityDomainTypeSilicon: return "OS_ELIGIBILITY_DOMAIN_SILICON";
        case EligibilityDomainTypePhosphorus: return "OS_ELIGIBILITY_DOMAIN_PHOSPHORUS";
        case EligibilityDomainTypeSulfur: return "OS_ELIGIBILITY_DOMAIN_SULFUR";
        case EligibilityDomainTypeChlorine: return "OS_ELIGIBILITY_DOMAIN_CHLORINE";
        case EligibilityDomainTypeArgon: return "OS_ELIGIBILITY_DOMAIN_ARGON";
        case EligibilityDomainTypePotassium: return "OS_ELIGIBILITY_DOMAIN_POTASSIUM";
        case EligibilityDomainTypeCalcium: return "OS_ELIGIBILITY_DOMAIN_CALCIUM";
        case EligibilityDomainTypeScandium: return "OS_ELIGIBILITY_DOMAIN_SCANDIUM";
        case EligibilityDomainTypeTitanium: return "OS_ELIGIBILITY_DOMAIN_TITANIUM";
        case EligibilityDomainTypeVanadium: return "OS_ELIGIBILITY_DOMAIN_VANADIUM";
        case EligibilityDomainTypeChromium: return "OS_ELIGIBILITY_DOMAIN_CHROMIUM";
        case EligibilityDomainTypeManganese: return "OS_ELIGIBILITY_DOMAIN_MANGANESE";
        case EligibilityDomainTypeIron: return "OS_ELIGIBILITY_DOMAIN_IRON";
        case EligibilityDomainTypeCobalt: return "OS_ELIGIBILITY_DOMAIN_COBALT";
        case EligibilityDomainTypeNickel: return "OS_ELIGIBILITY_DOMAIN_NICKEL";
        case EligibilityDomainTypeCopper: return "OS_ELIGIBILITY_DOMAIN_COPPER";
        case EligibilityDomainTypeZinc: return "OS_ELIGIBILITY_DOMAIN_ZINC";
        case EligibilityDomainTypeGallium: return "OS_ELIGIBILITY_DOMAIN_GALLIUM";
        case EligibilityDomainTypeGermanium: return "OS_ELIGIBILITY_DOMAIN_GERMANIUM";
        case EligibilityDomainTypeArsenic: return "OS_ELIGIBILITY_DOMAIN_ARSENIC";
        case EligibilityDomainTypeSelenium: return "OS_ELIGIBILITY_DOMAIN_SELENIUM";
        case EligibilityDomainTypeBromine: return "OS_ELIGIBILITY_DOMAIN_BROMINE";
        case EligibilityDomainTypeKrypton: return "OS_ELIGIBILITY_DOMAIN_KRYPTON";
        case EligibilityDomainTypeRubidium: return "OS_ELIGIBILITY_DOMAIN_RUBIDIUM";
        case EligibilityDomainTypeStrontium: return "OS_ELIGIBILITY_DOMAIN_STRONTIUM";
        case EligibilityDomainTypeYttrium: return "OS_ELIGIBILITY_DOMAIN_YTTRIUM";
        case EligibilityDomainTypeZirconium: return "OS_ELIGIBILITY_DOMAIN_ZIRCONIUM";
        case EligibilityDomainTypeNiobium: return "OS_ELIGIBILITY_DOMAIN_NIOBIUM";
        case EligibilityDomainTypeMolybdenum: return "OS_ELIGIBILITY_DOMAIN_MOLYBDENUM";
        case EligibilityDomainTypeTechnetium: return "OS_ELIGIBILITY_DOMAIN_TECHNETIUM";
        case EligibilityDomainTypeRuthenium: return "OS_ELIGIBILITY_DOMAIN_RUTHENIUM";
        case EligibilityDomainTypeRhodium: return "OS_ELIGIBILITY_DOMAIN_RHODIUM";
        case EligibilityDomainTypePalladium: return "OS_ELIGIBILITY_DOMAIN_PALLADIUM";
        case EligibilityDomainTypeSilver: return "OS_ELIGIBILITY_DOMAIN_SILVER";
        case EligibilityDomainTypeCadmium: return "OS_ELIGIBILITY_DOMAIN_CADMIUM";
        case EligibilityDomainTypeIndium: return "OS_ELIGIBILITY_DOMAIN_INDIUM";
        case EligibilityDomainTypeTin: return "OS_ELIGIBILITY_DOMAIN_TIN";
        case EligibilityDomainTypeAntimony: return "OS_ELIGIBILITY_DOMAIN_ANTIMONY";
        case EligibilityDomainTypeTellurium: return "OS_ELIGIBILITY_DOMAIN_TELLURIUM";
        case EligibilityDomainTypeIodine: return "OS_ELIGIBILITY_DOMAIN_IODINE";
        case EligibilityDomainTypeXenon: return "OS_ELIGIBILITY_DOMAIN_XENON";
        case EligibilityDomainTypeCesium: return "OS_ELIGIBILITY_DOMAIN_CESIUM";
        case EligibilityDomainTypeBarium: return "OS_ELIGIBILITY_DOMAIN_BARIUM";
        case EligibilityDomainTypeLanthanum: return "OS_ELIGIBILITY_DOMAIN_LANTHANUM";
        case EligibilityDomainTypeCerium: return "OS_ELIGIBILITY_DOMAIN_CERIUM";
        case EligibilityDomainTypePraseodymium: return "OS_ELIGIBILITY_DOMAIN_PRASEODYMIUM";
        case EligibilityDomainTypeNeodymium: return "OS_ELIGIBILITY_DOMAIN_NEODYMIUM";
        case EligibilityDomainTypePromethium: return "OS_ELIGIBILITY_DOMAIN_PROMETHIUM";
        case EligibilityDomainTypeSamarium: return "OS_ELIGIBILITY_DOMAIN_SAMARIUM";
        case EligibilityDomainTypeEuropium: return "OS_ELIGIBILITY_DOMAIN_EUROPIUM";
        case EligibilityDomainTypeGadolinium: return "OS_ELIGIBILITY_DOMAIN_GADOLINIUM";
        case EligibilityDomainTypeTerbium: return "OS_ELIGIBILITY_DOMAIN_TERBIUM";
        case EligibilityDomainTypeDysprosium: return "OS_ELIGIBILITY_DOMAIN_DYSPROSIUM";
        case EligibilityDomainTypeHolmium: return "OS_ELIGIBILITY_DOMAIN_HOLMIUM";
        case EligibilityDomainTypeErbium: return "OS_ELIGIBILITY_DOMAIN_ERBIUM";
        case EligibilityDomainTypeThulium: return "OS_ELIGIBILITY_DOMAIN_THULIUM";
        case EligibilityDomainTypeYtterbium: return "OS_ELIGIBILITY_DOMAIN_YTTERBIUM";
        case EligibilityDomainTypeLutetium: return "OS_ELIGIBILITY_DOMAIN_LUTETIUM";
        case EligibilityDomainTypeHafnium: return "OS_ELIGIBILITY_DOMAIN_HAFNIUM";
        case EligibilityDomainTypeTantalum: return "OS_ELIGIBILITY_DOMAIN_TANTALUM";
        case EligibilityDomainTypeTungsten: return "OS_ELIGIBILITY_DOMAIN_TUNGSTEN";
        case EligibilityDomainTypeRhenium: return "OS_ELIGIBILITY_DOMAIN_RHENIUM";
        case EligibilityDomainTypeOsmium: return "OS_ELIGIBILITY_DOMAIN_OSMIUM";
        case EligibilityDomainTypeIridium: return "OS_ELIGIBILITY_DOMAIN_IRIDIUM";
        case EligibilityDomainTypePlatinum: return "OS_ELIGIBILITY_DOMAIN_PLATINUM";
        case EligibilityDomainTypeGold: return "OS_ELIGIBILITY_DOMAIN_GOLD";
        case EligibilityDomainTypeMercury: return "OS_ELIGIBILITY_DOMAIN_MERCURY";
        case EligibilityDomainTypeThallium: return "OS_ELIGIBILITY_DOMAIN_THALLIUM";
        case EligibilityDomainTypeLead: return "OS_ELIGIBILITY_DOMAIN_LEAD";
        case EligibilityDomainTypeBismuth: return "OS_ELIGIBILITY_DOMAIN_BISMUTH";
        case EligibilityDomainTypePolonium: return "OS_ELIGIBILITY_DOMAIN_POLONIUM";
        case EligibilityDomainTypeAstatine: return "OS_ELIGIBILITY_DOMAIN_ASTATINE";
        case EligibilityDomainTypeRadon: return "OS_ELIGIBILITY_DOMAIN_RADON";
        case EligibilityDomainTypeFrancium: return "OS_ELIGIBILITY_DOMAIN_FRANCIUM";
        case EligibilityDomainTypeRadium: return "OS_ELIGIBILITY_DOMAIN_RADIUM";
        case EligibilityDomainTypeActinium: return "OS_ELIGIBILITY_DOMAIN_ACTINIUM";
        case EligibilityDomainTypeThorium: return "OS_ELIGIBILITY_DOMAIN_THORIUM";
        case EligibilityDomainTypeProtactinium: return "OS_ELIGIBILITY_DOMAIN_PROTACTINIUM";
        case EligibilityDomainTypeUranium: return "OS_ELIGIBILITY_DOMAIN_URANIUM";
        case EligibilityDomainTypeNeptunium: return "OS_ELIGIBILITY_DOMAIN_NEPTUNIUM";
        case EligibilityDomainTypePlutonium: return "OS_ELIGIBILITY_DOMAIN_PLUTONIUM";
        case EligibilityDomainTypeAmericium: return "OS_ELIGIBILITY_DOMAIN_AMERICIUM";
        case EligibilityDomainTypeCurium: return "OS_ELIGIBILITY_DOMAIN_CURIUM";
        case EligibilityDomainTypeBerkelium: return "OS_ELIGIBILITY_DOMAIN_BERKELIUM";
        case EligibilityDomainTypeCalifornium: return "OS_ELIGIBILITY_DOMAIN_CALIFORNIUM";
        case EligibilityDomainTypeEinsteinium: return "OS_ELIGIBILITY_DOMAIN_EINSTEINIUM";
        case EligibilityDomainTypeFermium: return "OS_ELIGIBILITY_DOMAIN_FERMIUM";
        case EligibilityDomainTypeMendelevium: return "OS_ELIGIBILITY_DOMAIN_MENDELEVIUM";
        case EligibilityDomainTypeNobelium: return "OS_ELIGIBILITY_DOMAIN_NOBELIUM";
        case EligibilityDomainTypeLawrencium: return "OS_ELIGIBILITY_DOMAIN_LAWRENCIUM";
        case EligibilityDomainTypeRutherfordium: return "OS_ELIGIBILITY_DOMAIN_RUTHERFORDIUM";
        case EligibilityDomainTypeDubnium: return "OS_ELIGIBILITY_DOMAIN_DUBNIUM";
        case EligibilityDomainTypeSeaborgium: return "OS_ELIGIBILITY_DOMAIN_SEABORGIUM";
        case EligibilityDomainTypeBohrium: return "OS_ELIGIBILITY_DOMAIN_BOHRIUM";
        case EligibilityDomainTypeHassium: return "OS_ELIGIBILITY_DOMAIN_HASSIUM";
        case EligibilityDomainTypeMeitnerium: return "OS_ELIGIBILITY_DOMAIN_MEITNERIUM";
        case EligibilityDomainTypeDarmstadtium: return "OS_ELIGIBILITY_DOMAIN_DARMSTADTIUM";
        case EligibilityDomainTypeRoentgenium: return "OS_ELIGIBILITY_DOMAIN_ROENTGENIUM";
        case EligibilityDomainTypeCopernicium: return "OS_ELIGIBILITY_DOMAIN_COPERNICIUM";
        case EligibilityDomainTypeNihonium: return "OS_ELIGIBILITY_DOMAIN_NIHONIUM";
        case EligibilityDomainTypeFlerovium: return "OS_ELIGIBILITY_DOMAIN_FLEROVIUM";
        case EligibilityDomainTypeMoscovium: return "OS_ELIGIBILITY_DOMAIN_MOSCOVIUM";
        case EligibilityDomainTypeLivermorium: return "OS_ELIGIBILITY_DOMAIN_LIVERMORIUM";
        case EligibilityDomainTypeTennessine: return "OS_ELIGIBILITY_DOMAIN_TENNESSINE";
        case EligibilityDomainTypeOganesson: return "OS_ELIGIBILITY_DOMAIN_OGANESSON";
        case EligibilityDomainTypeTest: return "OS_ELIGIBILITY_DOMAIN_TEST";
        case EligibilityDomainTypePodcastsTranscripts: return "OS_ELIGIBILITY_DOMAIN_PODCASTS_TRANSCRIPTS";
        case EligibilityDomainTypeGreymatter: return "OS_ELIGIBILITY_DOMAIN_GREYMATTER";
        case EligibilityDomainTypeXcodeLLM: return "OS_ELIGIBILITY_DOMAIN_XCODE_LLM";
        case EligibilityDomainTypeSearchMarketplaces: return "OS_ELIGIBILITY_DOMAIN_SEARCH_MARKETPLACES";
        default: return nil;
    }
}
