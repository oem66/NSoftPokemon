//
//  SBString.swift
//  NSoftPokemon
//
//  Created by OMERS on 9. 8. 2021..
//

import Foundation

func SBLocalization(_ string: String) -> String {
    return NSLocalizedString(string, comment: "")
}

struct SBString {
    
    public static var lang: String { return SBLocalization("lang") }
    
    static var as_username_label: String { return SBLocalization("auth_screen_username_label") }
    static var as_continue_button: String { return SBLocalization("auth_screen_conntinue_button") }
    static var as_text_field: String { return SBLocalization("auth_screen_username_text_field") }
    static var welcome_title: String { return SBLocalization("welcome_screen_title") }
    static var back_button: String { return SBLocalization("favorite_screen_back_button") }
    static var ws_username_label: String { return SBLocalization("welcome_screen_username_label") }
    static var ws_button_title: String { return SBLocalization("welcome_screen_button_title") }
    static var hs_alert_title: String { return SBLocalization("home_screen_alert_title") }
    static var hs_alert_message: String { return SBLocalization("home_screen_alert_message") }
    static var hs_alert_action: String { return SBLocalization("home_screen_alert_action") }
    static var hs_favorite_button: String { return SBLocalization("home_screen_favorites_button") }
    static var fs_title: String { return SBLocalization("favorite_screen_title") }
    static var fs_remove_button: String { return SBLocalization("favorite_screen_remove_button") }
    static var pds_back_button: String { return SBLocalization("pokemon_details_screen_back_button") }
    static var pds_base_experience: String { return SBLocalization("pokemon_details_screen_base_experience") }
    static var pds_weight: String { return SBLocalization("pokemon_details_screen_weight") }
    static var pds_types: String { return SBLocalization("pokemon_details_screen_types") }
    static var pds_button_title: String { return SBLocalization("pokemon_details_screen_button_title") }
    
    static var alert_action_ok: String { return SBLocalization("alert_action_ok") }
    static var alert_title_success: String { return SBLocalization("alert_title_success") }
    static var alert_message_added_fav: String { return SBLocalization("alert_message_added_favorites") }
    static var alert_message_removed_fav: String { return SBLocalization("alert_message_removed_favorites") }
    static var alert_title_username_invalid: String { return SBLocalization("auth_screen_alert_title") }
    static var alert_message_username_invalid: String { return SBLocalization("auth_screen_alert_message") }
}
