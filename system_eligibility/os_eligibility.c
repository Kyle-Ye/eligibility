//
//  os_eligibility.c
//  system_eligibility
//
//  Created by Kyle on 2024/7/2.
//  Audited for RELEASE_2024_BETA_1
//  Status: WIP

#include "os_eligibility.h"
#include "eligibility_plist.h"
#include "eligibility_xpc.h"
#include "eligibility_log_handle.h"
#include "EligibilityDomainTypeHelper.h"
#include "EligibilityInputTypeHelper.h"
#include "EligibilityAnswerSource.h"
#include <xpc/xpc.h>

EligibilityDomainType os_eligibility_domain_for_name(const char *name) {
    if (!name) {
        return EligibilityDomainTypeInvalid;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_INVALID") == 0) {
        return EligibilityDomainTypeInvalid;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_TEST") == 0) {
        return EligibilityDomainTypeTest;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_LOTX") == 0) {
        return EligibilityDomainTypeLotX;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_PODCASTS_TRANSCRIPTS") == 0) {
        return EligibilityDomainTypePodcastsTranscripts;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_GREYMATTER") == 0) {
        return EligibilityDomainTypeGreymatter;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_XCODE_LLM") == 0) {
        return EligibilityDomainTypeXcodeLLM;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_SEARCH_MARKETPLACES") == 0) {
        return EligibilityDomainTypeSearchMarketplaces;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_HYDROGEN") == 0) {
        return EligibilityDomainTypeHydrogen;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_HELIUM") == 0) {
        return EligibilityDomainTypeHelium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_LITHIUM") == 0) {
        return EligibilityDomainTypeLithium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_BERYLLIUM") == 0) {
        return EligibilityDomainTypeBeryllium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_BORON") == 0) {
        return EligibilityDomainTypeBoron;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_CARBON") == 0) {
        return EligibilityDomainTypeCarbon;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_NITROGEN") == 0) {
        return EligibilityDomainTypeNitrogen;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_OXYGEN") == 0) {
        return EligibilityDomainTypeOxygen;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_FLUORINE") == 0) {
        return EligibilityDomainTypeFluorine;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_NEON") == 0) {
        return EligibilityDomainTypeNeon;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_SODIUM") == 0) {
        return EligibilityDomainTypeSodium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_MAGNESIUM") == 0) {
        return EligibilityDomainTypeMagnesium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_ALUMINUM") == 0) {
        return EligibilityDomainTypeAluminum;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_SILICON") == 0) {
        return EligibilityDomainTypeSilicon;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_PHOSPHORUS") == 0) {
        return EligibilityDomainTypePhosphorus;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_SULFUR") == 0) {
        return EligibilityDomainTypeSulfur;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_CHLORINE") == 0) {
        return EligibilityDomainTypeChlorine;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_ARGON") == 0) {
        return EligibilityDomainTypeArgon;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_POTASSIUM") == 0) {
        return EligibilityDomainTypePotassium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_CALCIUM") == 0) {
        return EligibilityDomainTypeCalcium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_SCANDIUM") == 0) {
        return EligibilityDomainTypeScandium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_TITANIUM") == 0) {
        return EligibilityDomainTypeTitanium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_VANADIUM") == 0) {
        return EligibilityDomainTypeVanadium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_CHROMIUM") == 0) {
        return EligibilityDomainTypeChromium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_MANGANESE") == 0) {
        return EligibilityDomainTypeManganese;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_IRON") == 0) {
        return EligibilityDomainTypeIron;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_COBALT") == 0) {
        return EligibilityDomainTypeCobalt;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_NICKEL") == 0) {
        return EligibilityDomainTypeNickel;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_COPPER") == 0) {
        return EligibilityDomainTypeCopper;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_ZINC") == 0) {
        return EligibilityDomainTypeZinc;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_GALLIUM") == 0) {
        return EligibilityDomainTypeGallium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_GERMANIUM") == 0) {
        return EligibilityDomainTypeGermanium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_ARSENIC") == 0) {
        return EligibilityDomainTypeArsenic;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_SELENIUM") == 0) {
        return EligibilityDomainTypeSelenium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_BROMINE") == 0) {
        return EligibilityDomainTypeBromine;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_KRYPTON") == 0) {
        return EligibilityDomainTypeKrypton;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_RUBIDIUM") == 0) {
        return EligibilityDomainTypeRubidium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_STRONTIUM") == 0) {
        return EligibilityDomainTypeStrontium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_YTTRIUM") == 0) {
        return EligibilityDomainTypeYttrium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_ZIRCONIUM") == 0) {
        return EligibilityDomainTypeZirconium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_NIOBIUM") == 0) {
        return EligibilityDomainTypeNiobium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_MOLYBDENUM") == 0) {
        return EligibilityDomainTypeMolybdenum;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_TECHNETIUM") == 0) {
        return EligibilityDomainTypeTechnetium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_RUTHENIUM") == 0) {
        return EligibilityDomainTypeRuthenium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_RHODIUM") == 0) {
        return EligibilityDomainTypeRhodium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_PALLADIUM") == 0) {
        return EligibilityDomainTypePalladium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_SILVER") == 0) {
        return EligibilityDomainTypeSilver;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_CADMIUM") == 0) {
        return EligibilityDomainTypeCadmium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_INDIUM") == 0) {
        return EligibilityDomainTypeIndium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_TIN") == 0) {
        return EligibilityDomainTypeTin;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_ANTIMONY") == 0) {
        return EligibilityDomainTypeAntimony;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_TELLURIUM") == 0) {
        return EligibilityDomainTypeTellurium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_IODINE") == 0) {
        return EligibilityDomainTypeIodine;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_XENON") == 0) {
        return EligibilityDomainTypeXenon;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_CESIUM") == 0) {
        return EligibilityDomainTypeCesium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_BARIUM") == 0) {
        return EligibilityDomainTypeBarium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_LANTHANUM") == 0) {
        return EligibilityDomainTypeLanthanum;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_CERIUM") == 0) {
        return EligibilityDomainTypeCerium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_PRASEODYMIUM") == 0) {
        return EligibilityDomainTypePraseodymium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_NEODYMIUM") == 0) {
        return EligibilityDomainTypeNeodymium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_PROMETHIUM") == 0) {
        return EligibilityDomainTypePromethium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_SAMARIUM") == 0) {
        return EligibilityDomainTypeSamarium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_EUROPIUM") == 0) {
        return EligibilityDomainTypeEuropium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_GADOLINIUM") == 0) {
        return EligibilityDomainTypeGadolinium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_TERBIUM") == 0) {
        return EligibilityDomainTypeTerbium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_DYSPROSIUM") == 0) {
        return EligibilityDomainTypeDysprosium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_HOLMIUM") == 0) {
        return EligibilityDomainTypeHolmium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_ERBIUM") == 0) {
        return EligibilityDomainTypeErbium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_THULIUM") == 0) {
        return EligibilityDomainTypeThulium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_YTTERBIUM") == 0) {
        return EligibilityDomainTypeYtterbium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_LUTETIUM") == 0) {
        return EligibilityDomainTypeLutetium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_HAFNIUM") == 0) {
        return EligibilityDomainTypeHafnium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_TANTALUM") == 0) {
        return EligibilityDomainTypeTantalum;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_TUNGSTEN") == 0) {
        return EligibilityDomainTypeTungsten;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_RHENIUM") == 0) {
        return EligibilityDomainTypeRhenium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_OSMIUM") == 0) {
        return EligibilityDomainTypeOsmium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_IRIDIUM") == 0) {
        return EligibilityDomainTypeIridium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_PLATINUM") == 0) {
        return EligibilityDomainTypePlatinum;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_GOLD") == 0) {
        return EligibilityDomainTypeGold;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_MERCURY") == 0) {
        return EligibilityDomainTypeMercury;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_THALLIUM") == 0) {
        return EligibilityDomainTypeThallium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_LEAD") == 0) {
        return EligibilityDomainTypeLead;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_BISMUTH") == 0) {
        return EligibilityDomainTypeBismuth;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_POLONIUM") == 0) {
        return EligibilityDomainTypePolonium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_ASTATINE") == 0) {
        return EligibilityDomainTypeAstatine;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_RADON") == 0) {
        return EligibilityDomainTypeRadon;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_FRANCIUM") == 0) {
        return EligibilityDomainTypeFrancium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_RADIUM") == 0) {
        return EligibilityDomainTypeRadium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_ACTINIUM") == 0) {
        return EligibilityDomainTypeActinium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_THORIUM") == 0) {
        return EligibilityDomainTypeThorium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_PROTACTINIUM") == 0) {
        return EligibilityDomainTypeProtactinium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_URANIUM") == 0) {
        return EligibilityDomainTypeUranium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_NEPTUNIUM") == 0) {
        return EligibilityDomainTypeNeptunium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_PLUTONIUM") == 0) {
        return EligibilityDomainTypePlutonium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_AMERICIUM") == 0) {
        return EligibilityDomainTypeAmericium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_CURIUM") == 0) {
        return EligibilityDomainTypeCurium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_BERKELIUM") == 0) {
        return EligibilityDomainTypeBerkelium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_CALIFORNIUM") == 0) {
        return EligibilityDomainTypeCalifornium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_EINSTEINIUM") == 0) {
        return EligibilityDomainTypeEinsteinium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_FERMIUM") == 0) {
        return EligibilityDomainTypeFermium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_MENDELEVIUM") == 0) {
        return EligibilityDomainTypeMendelevium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_NOBELIUM") == 0) {
        return EligibilityDomainTypeNobelium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_LAWRENCIUM") == 0) {
        return EligibilityDomainTypeLawrencium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_RUTHERFORDIUM") == 0) {
        return EligibilityDomainTypeRutherfordium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_DUBNIUM") == 0) {
        return EligibilityDomainTypeDubnium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_SEABORGIUM") == 0) {
        return EligibilityDomainTypeSeaborgium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_BOHRIUM") == 0) {
        return EligibilityDomainTypeBohrium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_HASSIUM") == 0) {
        return EligibilityDomainTypeHassium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_MEITNERIUM") == 0) {
        return EligibilityDomainTypeMeitnerium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_DARMSTADTIUM") == 0) {
        return EligibilityDomainTypeDarmstadtium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_ROENTGENIUM") == 0) {
        return EligibilityDomainTypeRoentgenium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_COPERNICIUM") == 0) {
        return EligibilityDomainTypeCopernicium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_NIHONIUM") == 0) {
        return EligibilityDomainTypeNihonium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_FLEROVIUM") == 0) {
        return EligibilityDomainTypeFlerovium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_MOSCOVIUM") == 0) {
        return EligibilityDomainTypeMoscovium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_LIVERMORIUM") == 0) {
        return EligibilityDomainTypeLivermorium;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_TENNESSINE") == 0) {
        return EligibilityDomainTypeTennessine;
    } else if (strcmp(name, "OS_ELIGIBILITY_DOMAIN_OGANESSON") == 0) {
        return EligibilityDomainTypeOganesson;
    } else {
        return EligibilityDomainTypeInvalid;
    }
}

const char * os_eligibility_get_domain_notification_name(EligibilityDomainType domain) {
    switch (domain) {
        case EligibilityDomainTypeLotX: return "com.apple.os-eligibility-domain.change.lotx";
        case EligibilityDomainTypeHydrogen: return "com.apple.os-eligibility-domain.change.hydrogen";
        case EligibilityDomainTypeHelium: return "com.apple.os-eligibility-domain.change.helium";
        case EligibilityDomainTypeLithium: return "com.apple.os-eligibility-domain.change.lithium";
        case EligibilityDomainTypeBeryllium: return "com.apple.os-eligibility-domain.change.beryllium";
        case EligibilityDomainTypeBoron: return "com.apple.os-eligibility-domain.change.boron";
        case EligibilityDomainTypeCarbon: return "com.apple.os-eligibility-domain.change.carbon";
        case EligibilityDomainTypeNitrogen: return "com.apple.os-eligibility-domain.change.nitrogen";
        case EligibilityDomainTypeOxygen: return "com.apple.os-eligibility-domain.change.oxygen";
        case EligibilityDomainTypeFluorine: return "com.apple.os-eligibility-domain.change.fluorine";
        case EligibilityDomainTypeNeon: return "com.apple.os-eligibility-domain.change.neon";
        case EligibilityDomainTypeSodium: return "com.apple.os-eligibility-domain.change.sodium";
        case EligibilityDomainTypeMagnesium: return "com.apple.os-eligibility-domain.change.magnesium";
        case EligibilityDomainTypeAluminum: return "com.apple.os-eligibility-domain.change.aluminum";
        case EligibilityDomainTypeSilicon: return "com.apple.os-eligibility-domain.change.silicon";
        case EligibilityDomainTypePhosphorus: return "com.apple.os-eligibility-domain.change.phosphorus";
        case EligibilityDomainTypeSulfur: return "com.apple.os-eligibility-domain.change.sulfur";
        case EligibilityDomainTypeChlorine: return "com.apple.os-eligibility-domain.change.chlorine";
        case EligibilityDomainTypeArgon: return "com.apple.os-eligibility-domain.change.argon";
        case EligibilityDomainTypePotassium: return "com.apple.os-eligibility-domain.change.potassium";
        case EligibilityDomainTypeCalcium: return "com.apple.os-eligibility-domain.change.calcium";
        case EligibilityDomainTypeScandium: return "com.apple.os-eligibility-domain.change.scandium";
        case EligibilityDomainTypeTitanium: return "com.apple.os-eligibility-domain.change.titanium";
        case EligibilityDomainTypeVanadium: return "com.apple.os-eligibility-domain.change.vanadium";
        case EligibilityDomainTypeChromium: return "com.apple.os-eligibility-domain.change.chromium";
        case EligibilityDomainTypeManganese: return "com.apple.os-eligibility-domain.change.manganese";
        case EligibilityDomainTypeIron: return "com.apple.os-eligibility-domain.change.iron";
        case EligibilityDomainTypeCobalt: return "com.apple.os-eligibility-domain.change.cobalt";
        case EligibilityDomainTypeNickel: return "com.apple.os-eligibility-domain.change.nickel";
        case EligibilityDomainTypeCopper: return "com.apple.os-eligibility-domain.change.copper";
        case EligibilityDomainTypeZinc: return "com.apple.os-eligibility-domain.change.zinc";
        case EligibilityDomainTypeGallium: return "com.apple.os-eligibility-domain.change.gallium";
        case EligibilityDomainTypeGermanium: return "com.apple.os-eligibility-domain.change.germanium";
        case EligibilityDomainTypeArsenic: return "com.apple.os-eligibility-domain.change.arsenic";
        case EligibilityDomainTypeSelenium: return "com.apple.os-eligibility-domain.change.selenium";
        case EligibilityDomainTypeBromine: return "com.apple.os-eligibility-domain.change.bromine";
        case EligibilityDomainTypeKrypton: return "com.apple.os-eligibility-domain.change.krypton";
        case EligibilityDomainTypeRubidium: return "com.apple.os-eligibility-domain.change.rubidium";
        case EligibilityDomainTypeStrontium: return "com.apple.os-eligibility-domain.change.strontium";
        case EligibilityDomainTypeYttrium: return "com.apple.os-eligibility-domain.change.yttrium";
        case EligibilityDomainTypeZirconium: return "com.apple.os-eligibility-domain.change.zirconium";
        case EligibilityDomainTypeNiobium: return "com.apple.os-eligibility-domain.change.niobium";
        case EligibilityDomainTypeMolybdenum: return "com.apple.os-eligibility-domain.change.molybdenum";
        case EligibilityDomainTypeTechnetium: return "com.apple.os-eligibility-domain.change.technetium";
        case EligibilityDomainTypeRuthenium: return "com.apple.os-eligibility-domain.change.ruthenium";
        case EligibilityDomainTypeRhodium: return "com.apple.os-eligibility-domain.change.rhodium";
        case EligibilityDomainTypePalladium: return "com.apple.os-eligibility-domain.change.palladium";
        case EligibilityDomainTypeSilver: return "com.apple.os-eligibility-domain.change.silver";
        case EligibilityDomainTypeCadmium: return "com.apple.os-eligibility-domain.change.cadmium";
        case EligibilityDomainTypeIndium: return "com.apple.os-eligibility-domain.change.indium";
        case EligibilityDomainTypeTin: return "com.apple.os-eligibility-domain.change.tin";
        case EligibilityDomainTypeAntimony: return "com.apple.os-eligibility-domain.change.antimony";
        case EligibilityDomainTypeTellurium: return "com.apple.os-eligibility-domain.change.tellurium";
        case EligibilityDomainTypeIodine: return "com.apple.os-eligibility-domain.change.iodine";
        case EligibilityDomainTypeXenon: return "com.apple.os-eligibility-domain.change.xenon";
        case EligibilityDomainTypeCesium: return "com.apple.os-eligibility-domain.change.cesium";
        case EligibilityDomainTypeBarium: return "com.apple.os-eligibility-domain.change.barium";
        case EligibilityDomainTypeLanthanum: return "com.apple.os-eligibility-domain.change.lanthanum";
        case EligibilityDomainTypeCerium: return "com.apple.os-eligibility-domain.change.cerium";
        case EligibilityDomainTypePraseodymium: return "com.apple.os-eligibility-domain.change.praseodymium";
        case EligibilityDomainTypeNeodymium: return "com.apple.os-eligibility-domain.change.neodymium";
        case EligibilityDomainTypePromethium: return "com.apple.os-eligibility-domain.change.promethium";
        case EligibilityDomainTypeSamarium: return "com.apple.os-eligibility-domain.change.samarium";
        case EligibilityDomainTypeEuropium: return "com.apple.os-eligibility-domain.change.europium";
        case EligibilityDomainTypeGadolinium: return "com.apple.os-eligibility-domain.change.gadolinium";
        case EligibilityDomainTypeTerbium: return "com.apple.os-eligibility-domain.change.terbium";
        case EligibilityDomainTypeDysprosium: return "com.apple.os-eligibility-domain.change.dysprosium";
        case EligibilityDomainTypeHolmium: return "com.apple.os-eligibility-domain.change.holmium";
        case EligibilityDomainTypeErbium: return "com.apple.os-eligibility-domain.change.erbium";
        case EligibilityDomainTypeThulium: return "com.apple.os-eligibility-domain.change.thulium";
        case EligibilityDomainTypeYtterbium: return "com.apple.os-eligibility-domain.change.ytterbium";
        case EligibilityDomainTypeLutetium: return "com.apple.os-eligibility-domain.change.lutetium";
        case EligibilityDomainTypeHafnium: return "com.apple.os-eligibility-domain.change.hafnium";
        case EligibilityDomainTypeTantalum: return "com.apple.os-eligibility-domain.change.tantalum";
        case EligibilityDomainTypeTungsten: return "com.apple.os-eligibility-domain.change.tungsten";
        case EligibilityDomainTypeRhenium: return "com.apple.os-eligibility-domain.change.rhenium";
        case EligibilityDomainTypeOsmium: return "com.apple.os-eligibility-domain.change.osmium";
        case EligibilityDomainTypeIridium: return "com.apple.os-eligibility-domain.change.iridium";
        case EligibilityDomainTypePlatinum: return "com.apple.os-eligibility-domain.change.platinum";
        case EligibilityDomainTypeGold: return "com.apple.os-eligibility-domain.change.gold";
        case EligibilityDomainTypeMercury: return "com.apple.os-eligibility-domain.change.mercury";
        case EligibilityDomainTypeThallium: return "com.apple.os-eligibility-domain.change.thallium";
        case EligibilityDomainTypeLead: return "com.apple.os-eligibility-domain.change.lead";
        case EligibilityDomainTypeBismuth: return "com.apple.os-eligibility-domain.change.bismuth";
        case EligibilityDomainTypePolonium: return "com.apple.os-eligibility-domain.change.polonium";
        case EligibilityDomainTypeAstatine: return "com.apple.os-eligibility-domain.change.astatine";
        case EligibilityDomainTypeRadon: return "com.apple.os-eligibility-domain.change.radon";
        case EligibilityDomainTypeFrancium: return "com.apple.os-eligibility-domain.change.francium";
        case EligibilityDomainTypeRadium: return "com.apple.os-eligibility-domain.change.radium";
        case EligibilityDomainTypeActinium: return "com.apple.os-eligibility-domain.change.actinium";
        case EligibilityDomainTypeThorium: return "com.apple.os-eligibility-domain.change.thorium";
        case EligibilityDomainTypeProtactinium: return "com.apple.os-eligibility-domain.change.protactinium";
        case EligibilityDomainTypeUranium: return "com.apple.os-eligibility-domain.change.uranium";
        case EligibilityDomainTypeNeptunium: return "com.apple.os-eligibility-domain.change.neptunium";
        case EligibilityDomainTypePlutonium: return "com.apple.os-eligibility-domain.change.plutonium";
        case EligibilityDomainTypeAmericium: return "com.apple.os-eligibility-domain.change.americium";
        case EligibilityDomainTypeCurium: return "com.apple.os-eligibility-domain.change.curium";
        case EligibilityDomainTypeBerkelium: return "com.apple.os-eligibility-domain.change.berkelium";
        case EligibilityDomainTypeCalifornium: return "com.apple.os-eligibility-domain.change.californium";
        case EligibilityDomainTypeEinsteinium: return "com.apple.os-eligibility-domain.change.einsteinium";
        case EligibilityDomainTypeFermium: return "com.apple.os-eligibility-domain.change.fermium";
        case EligibilityDomainTypeMendelevium: return "com.apple.os-eligibility-domain.change.mendelevium";
        case EligibilityDomainTypeNobelium: return "com.apple.os-eligibility-domain.change.nobelium";
        case EligibilityDomainTypeLawrencium: return "com.apple.os-eligibility-domain.change.lawrencium";
        case EligibilityDomainTypeRutherfordium: return "com.apple.os-eligibility-domain.change.rutherfordium";
        case EligibilityDomainTypeDubnium: return "com.apple.os-eligibility-domain.change.dubnium";
        case EligibilityDomainTypeSeaborgium: return "com.apple.os-eligibility-domain.change.seaborgium";
        case EligibilityDomainTypeBohrium: return "com.apple.os-eligibility-domain.change.bohrium";
        case EligibilityDomainTypeHassium: return "com.apple.os-eligibility-domain.change.hassium";
        case EligibilityDomainTypeMeitnerium: return "com.apple.os-eligibility-domain.change.meitnerium";
        case EligibilityDomainTypeDarmstadtium: return "com.apple.os-eligibility-domain.change.darmstadtium";
        case EligibilityDomainTypeRoentgenium: return "com.apple.os-eligibility-domain.change.roentgenium";
        case EligibilityDomainTypeCopernicium: return "com.apple.os-eligibility-domain.change.copernicium";
        case EligibilityDomainTypeNihonium: return "com.apple.os-eligibility-domain.change.nihonium";
        case EligibilityDomainTypeFlerovium: return "com.apple.os-eligibility-domain.change.flerovium";
        case EligibilityDomainTypeMoscovium: return "com.apple.os-eligibility-domain.change.moscovium";
        case EligibilityDomainTypeLivermorium: return "com.apple.os-eligibility-domain.change.livermorium";
        case EligibilityDomainTypeTennessine: return "com.apple.os-eligibility-domain.change.tennessine";
        case EligibilityDomainTypeOganesson: return "com.apple.os-eligibility-domain.change.oganesson";
        case EligibilityDomainTypeTest: return "com.apple.os-eligibility-domain.change.test";
        case EligibilityDomainTypePodcastsTranscripts: return "com.apple.os-eligibility-domain.change.podcasts-transcripts";
        case EligibilityDomainTypeGreymatter: return "com.apple.os-eligibility-domain.change.greymatter";
        case EligibilityDomainTypeXcodeLLM: return "com.apple.os-eligibility-domain.change.xcode-llm";
        case EligibilityDomainTypeSearchMarketplaces: return "com.apple.os-eligibility-domain.change.search-marketplaces";
        default:
            os_log_error(eligibility_log_handle(), "%s: Unable to convert domain to notification string: %llu", __func__, domain);
            return nil;
    }
}

int os_eligibility_set_input(EligibilityInputType input, xpc_object_t value, EligibilityInputStatus status) {
    xpc_object_t message = xpc_dictionary_create(NULL, NULL, 0);
    eligibility_xpc_set_message_type(EligibilityXPCMessageTypeSetInput, message);
    xpc_dictionary_set_uint64(message, "input", input);
    if (value) {
        xpc_dictionary_set_value(message, "value", value);
    }
    xpc_dictionary_set_uint64(message, "status", status);
    int error_num = eligibility_xpc_send_message_with_reply(message, NULL);
    xpc_release(message);
    return error_num;
}

int os_eligibility_reset_domain(EligibilityDomainType domain) {
    xpc_object_t message = xpc_dictionary_create(NULL, NULL, 0);
    eligibility_xpc_set_message_type(EligibilityXPCMessageTypeResetDomain, message);
    xpc_dictionary_set_uint64(message, "domain", domain);
    int error_num = eligibility_xpc_send_message_with_reply(message, NULL);
    xpc_release(message);
    return error_num;
}

int os_eligibility_force_domain_answer(EligibilityDomainType domain, EligibilityAnswer answer, xpc_object_t context) {
    xpc_object_t message = xpc_dictionary_create(NULL, NULL, 0);
    eligibility_xpc_set_message_type(ELIGIBILITYXPCMessageTypeForceDomainAnswer, message);
    xpc_dictionary_set_uint64(message, "domain", domain);
    xpc_dictionary_set_uint64(message, "answer", answer);
    if (context) {
        xpc_dictionary_set_value(message, "context", context);
    }
    int error_num = eligibility_xpc_send_message_with_reply(message, NULL);
    xpc_release(message);
    return error_num;
}

int os_eligibility_get_internal_state(xpc_object_t* internal_state_ptr) {
    if (internal_state_ptr == NULL) {
        return EINVAL;
    }
    xpc_object_t message = xpc_dictionary_create(NULL, NULL, 0);
    eligibility_xpc_set_message_type(ELIGIBILITYXPCMessageTypeGetInternalState, message);
    xpc_object_t reply = NULL;
    int error_num = eligibility_xpc_send_message_with_reply(message, &reply);
    if (error_num == 0) {
        xpc_object_t internal_state = xpc_dictionary_get_dictionary(reply, "internalStateDictionary");
        if (internal_state) {
            xpc_retain(internal_state);
        }
        *internal_state_ptr = internal_state;
    }
    if (reply) {
        xpc_release(reply);
    }
    xpc_release(message);
    return error_num;
}

int os_eligibility_reset_all_domains(void) {
    xpc_object_t message = xpc_dictionary_create(NULL, NULL, 0);
    eligibility_xpc_set_message_type(EligibilityXPCMessageTypeResetAllDomains, message);
    int error_num = eligibility_xpc_send_message_with_reply(message, NULL);
    xpc_release(message);
    return error_num;
}

int os_eligibility_force_domain_set_answers(EligibilityDomainSet domainSet, EligibilityAnswer answer, xpc_object_t context) {
    xpc_object_t message = xpc_dictionary_create(NULL, NULL, 0);
    eligibility_xpc_set_message_type(ELIGIBILITYXPCMessageTypeForceDomainSetAnswer, message);
    xpc_dictionary_set_uint64(message, "domainSet", domainSet);
    xpc_dictionary_set_uint64(message, "answer", answer);
    if (context) {
        xpc_dictionary_set_value(message, "context", context);
    }
    int error_num = eligibility_xpc_send_message_with_reply(message, NULL);
    xpc_release(message);
    return error_num;
}

int os_eligibility_get_state_dump(xpc_object_t* state_dump_dictionary_ptr) {
    if (state_dump_dictionary_ptr == NULL) {
        return EINVAL;
    }
    xpc_object_t message = xpc_dictionary_create(NULL, NULL, 0);
    eligibility_xpc_set_message_type(EligibilityXPCMessageTypeGetStateDump, message);
    xpc_object_t reply = NULL;
    int error_num = eligibility_xpc_send_message_with_reply(message, &reply);
    if (error_num == 0) {
        xpc_object_t state_dump_dictionary = xpc_dictionary_get_dictionary(reply, "stateDumpDictionary");
        if (state_dump_dictionary) {
            xpc_retain(state_dump_dictionary);
        }
        *state_dump_dictionary_ptr = state_dump_dictionary;
    }
    if (reply) {
        xpc_release(reply);
    }
    xpc_release(message);
    return error_num;
}

int os_eligibility_dump_sysdiagnose_data_to_dir(const char* dir_path) {
    if (dir_path == NULL) {
        return EINVAL;
    }
    xpc_object_t message = xpc_dictionary_create(NULL, NULL, 0);
    eligibility_xpc_set_message_type(EligibilityXPCMessageTypeDumpSysdiagnoseData, message);
    xpc_dictionary_set_string(message, "dirPath", dir_path);
    int error_num = eligibility_xpc_send_message_with_reply(message, NULL);
    xpc_release(message);
    return error_num;    
}

int os_eligibility_set_test_mode(bool enabled) {
    xpc_object_t message = xpc_dictionary_create(NULL, NULL, 0);
    eligibility_xpc_set_message_type(EligibilityXPCMessageTypeSetTestMode, message);
    xpc_dictionary_set_bool(message, "enabled", enabled);
    int error_num = eligibility_xpc_send_message_with_reply(message, NULL);
    xpc_release(message);
    return error_num;
}

int os_eligibility_get_domain_answer(EligibilityDomainType domain, EligibilityAnswer *answer_ptr, EligibilityAnswerSource* answer_source_ptr, xpc_object_t * status_ptr, xpc_object_t *context_ptr) {
    xpc_object_t plist = NULL;
    const char *path = eligibility_plist_path_for_domain(domain);
    int error_num = 0;
    EligibilityAnswer answer = EligibilityAnswerNotYetAvailable;
    EligibilityAnswerSource answer_source = EligibilityAnswerSourceInvalid;
    xpc_object_t status = NULL;
    int option = 0;
    if (!path) {
        os_log_error(eligibility_log_handle(), "%s: Unknown plist for domain %llu", __func__, domain);
        error_num = 22;
    } else {
        if (load_eligibility_plist(path, &plist)) {
            error_num = 0;
        } else {
            switch (domain) {
                case EligibilityDomainTypeLotX ... EligibilityDomainTypeCobalt:
                case EligibilityDomainTypeTest ... EligibilityDomainTypeSearchMarketplaces: {
                    const char *key = eligibility_domain_to_str(domain);
                    xpc_object_t domain_object = xpc_dictionary_get_dictionary(plist, key); // x28
                    if (!domain_object) {
                        os_log_error(eligibility_log_handle(), "%s: Domain %s(%llu) missing from plist", __func__, key, domain);
                        error_num = -1;
                        break;
                    }
                    answer = xpc_dictionary_get_int64(domain_object, "os_eligibility_answer_t"); // x26
                    if (answer < 0) {
                        os_log_error(eligibility_log_handle(), "%s: Unable to read eligibility answer for domain: %s", __func__, key);
                        error_num = EDOM;
                        break;
                    }
                    if (answer_source_ptr == NULL) {
                        answer_source = EligibilityAnswerSourceInvalid;
                        if (status_ptr != NULL) {
                            status = xpc_dictionary_get_value(domain_object, "status");
                            if (status != NULL) {
                                xpc_retain(status);
                            }
                        }
                        if (context_ptr != 0) {
                            xpc_object_t context = xpc_dictionary_get_dictionary(domain_object, "context");
                            if (context != NULL) {
                                xpc_retain(context);
                                error_num = 0;
                                *context_ptr = context;
                            }
                        } else {
                            error_num = 0;
                        }
                    } else {
                        answer_source = xpc_dictionary_get_int64(domain_object, "os_eligibility_answer_source_t");
                        if (answer_source < 0) {
                            os_log_error(eligibility_log_handle(), "%s: Unable to read eligibility source for domain: %s", __func__, key);
                            error_num = EDOM;
                            break;
                        }
                        *answer_source_ptr = answer_source;
                    }
                    break;
                }
                default:
                    os_log_error(eligibility_log_handle(), "%s: Invalid domain %llu", __func__, domain);
                    break;
            }
        }
    }
    free((void *)path);
    if (answer_ptr) {
        *answer_ptr = answer;
    }
    if (status_ptr == NULL) {
        if (status != NULL) {
            xpc_release(status);
        }
    } else {
        if (status != NULL || answer_source == EligibilityAnswerSourceForced) {
            *status_ptr = status;
        } else {
            xpc_object_t dict = xpc_dictionary_create(NULL, NULL, 0);
            switch (domain) {
                case EligibilityDomainTypeLotX:
                case EligibilityDomainTypeCobalt:
                    xpc_dictionary_set_int64(dict, eligibility_input_to_str(EligibilityInputTypeCountryLocation), 1);
                    break;
                case EligibilityDomainTypeFluorine:
                case EligibilityDomainTypeMagnesium:
                case EligibilityDomainTypeSilicon:
                case EligibilityDomainTypeChromium:
                case EligibilityDomainTypeManganese:
                    xpc_dictionary_set_int64(dict, eligibility_input_to_str(EligibilityInputTypeCountryBilling), 1);
                    xpc_dictionary_set_int64(dict, eligibility_input_to_str(EligibilityInputTypeDeviceClass), 1);
                    break;
                case EligibilityDomainTypeHydrogen:
                case EligibilityDomainTypeHelium:
                case EligibilityDomainTypeLithium:
                case EligibilityDomainTypeBeryllium:
                case EligibilityDomainTypeBoron:
                case EligibilityDomainTypeCarbon:
                case EligibilityDomainTypeNitrogen:
                case EligibilityDomainTypeOxygen:
                case EligibilityDomainTypeNeon:
                case EligibilityDomainTypeSodium:
                case EligibilityDomainTypeAluminum:
                case EligibilityDomainTypePhosphorus:
                case EligibilityDomainTypeSulfur:
                case EligibilityDomainTypeArgon:
                case EligibilityDomainTypePotassium:
                case EligibilityDomainTypeScandium:
                case EligibilityDomainTypeTitanium:
                case EligibilityDomainTypeVanadium:
                case EligibilityDomainTypeIron:
                case EligibilityDomainTypeSearchMarketplaces:
                    xpc_dictionary_set_int64(dict, eligibility_input_to_str(EligibilityInputTypeCountryLocation), 1);
                    xpc_dictionary_set_int64(dict, eligibility_input_to_str(EligibilityInputTypeCountryBilling), 1);
                    xpc_dictionary_set_int64(dict, eligibility_input_to_str(EligibilityInputTypeDeviceClass), 1);
                    break;
                case EligibilityDomainTypeChlorine:
                    xpc_dictionary_set_int64(dict, eligibility_input_to_str(EligibilityInputTypeCountryBilling), 1);
                    xpc_dictionary_set_int64(dict, eligibility_input_to_str(EligibilityInputTypeDeviceClass), 1);
                    xpc_dictionary_set_int64(dict, eligibility_input_to_str(EligibilityInputTypeDeviceLocale), 1);
                    break;
                case EligibilityDomainTypeCalcium:
                    xpc_dictionary_set_int64(dict, eligibility_input_to_str(EligibilityInputTypeChinaCellular), 1);
                case EligibilityDomainTypeTest:
                    xpc_dictionary_set_int64(dict, eligibility_input_to_str(EligibilityInputTypeCountryLocation), 1);
                    xpc_dictionary_set_int64(dict, eligibility_input_to_str(EligibilityInputTypeCountryBilling), 1);
                    break;
                case EligibilityDomainTypePodcastsTranscripts:
                    xpc_dictionary_set_int64(dict, eligibility_input_to_str(EligibilityInputTypeCountryLocation), 1);
                    xpc_dictionary_set_int64(dict, eligibility_input_to_str(EligibilityInputTypeCountryBilling), 1);
                    xpc_dictionary_set_int64(dict, eligibility_input_to_str(EligibilityInputTypeDeviceRegionCode), 1);
                    break;
                case EligibilityDomainTypeGreymatter:
                    xpc_dictionary_set_int64(dict, eligibility_input_to_str(EligibilityInputTypeCountryLocation), 1);
                    xpc_dictionary_set_int64(dict, eligibility_input_to_str(EligibilityInputTypeDeviceLocale), 1);
                    xpc_dictionary_set_int64(dict, eligibility_input_to_str(EligibilityInputTypeGenerativeModelSystem), 1);
                    xpc_dictionary_set_int64(dict, eligibility_input_to_str(EligibilityInputTypeDeviceRegionCode), 1);
                    xpc_dictionary_set_int64(dict, eligibility_input_to_str(EligibilityInputTypeSiriLanguage), 1);
                    break;
                case EligibilityDomainTypeXcodeLLM:
                    xpc_dictionary_set_int64(dict, eligibility_input_to_str(EligibilityInputTypeDeviceRegionCode), 1);
                    xpc_dictionary_set_int64(dict, eligibility_input_to_str(EligibilityInputTypeDeviceClass), 1);
                default:
                    break;
            }
            *status_ptr = dict;
        }
    }
    if (plist != NULL) {
        xpc_release(plist);
    }
    return error_num;
}

int os_eligibility_get_all_domain_answers(xpc_object_t *answers_ptr) {
    xpc_object_t dictionary = xpc_dictionary_create(NULL, NULL, 0);
    const char *answer_path = copy_eligibility_domain_answer_plist_path();
    const char *public_answer_path = copy_eligibility_domain_public_answer_plist_path();
    int error_num = _append_plist_keys_to_dictionary(answer_path, dictionary);
    if (error_num != 0) {
        os_log_info(eligibility_log_handle(), "%s: Failed to load in plist %s: error=%d", __func__, answer_path, error_num);
        dictionary = NULL;
    } else {
        error_num = _append_plist_keys_to_dictionary(public_answer_path, dictionary);
        if (error_num != 0) {
            os_log_info(eligibility_log_handle(), "%s: Failed to load in plist %s: error=%d", __func__, public_answer_path, error_num);
            dictionary = NULL;
        }
    }
    free((void *)answer_path);
    free((void *)public_answer_path);
    if (answers_ptr) {
        *answers_ptr = dictionary;
    }
    // FIXME: A potiential memory leak on dictionry. We should retain or release dictionary here
    return error_num;
}
