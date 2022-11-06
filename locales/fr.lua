local Translations = {
    error = {
        invalid_ext = "Ce n'est pas une extension valide, seul",
    },
    info = {
        use_printer = "Utiliser l'imprimante"

    },
    command = {
        spawn_printer = "Créer une imprimante"
    }
}

if GetConvar('qb_locale', 'en') == 'fr' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
