--[[
Minerals Core Mod by Noriel_Sylvire.
This mod registers the callbacks added by other mods in this modpack
and then executes them.
This modpack is an API for registering minerals in minetest.
Node, oregen, craftitems, crafting (recipes), tools, and all other
definitions typically associated with a mineral in minetest are
registered automatically by this API.

Copyright (c) 2020-2023 Noriel_Sylvire.

This library is free software; you can redistribute it and/or
modify it under the terms of the GNU Lesser General Public
License as published by the Free Software Foundation; either
version 2.1 of the License, or any later version.

This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public
License along with this library; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA

Contact Noriel_Sylvire via private message on the Minetest Forum:
https://forum.minetest.net/memberlist.php?mode=viewprofile&u=24116
or any social media attached to his Minetest Forum profile,
such as GitHub: https://github.com/NorielSylvire
or Twitter: https://twitter.com/Noriel_Sylvire
--]]

nsmc = {
	core_version = 1.2,
    registered_callbacks = {}
}

function nsmc.register_minerals(modname, minerals)

    for i, mineral in ipairs(minerals) do

        mineral = mineral or {}

        if not mineral.name then
            minetest.log("warning", "Mineral number "..(i+1).." in mod "..modname.." has no name. Registering as '"..modname..i.."mineral'.")
            mineral.name = modname..i.."mineral"
        end

        mineral.color = mineral.color or "no_color"	-- leave this blank if you do not want to colorize the texture
        mineral.texture_brightness = mineral.texture_brightness or "bright"

        for _, callback in ipairs(nsmc.registered_callbacks) do
            callback(modname, mineral)
        end
    end
end

function nsmc.register_callback(func)
    table.insert(nsmc.registered_callbacks, func)
end
