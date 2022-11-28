Config = Config or {}

Config.UseTarget = GetConvar('UseTarget', 'true') == 'true'

Config.ValidExtensions = {
    [".png"] = true,
    [".gif"] = true,
    [".jpg"] = true,
    [".jpeg"] = true,
    [".webm"] = true
}