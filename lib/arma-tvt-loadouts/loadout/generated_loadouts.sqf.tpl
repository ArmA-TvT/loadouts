// BLUEFOR weapons
{% for class in bluefor %}
tvtmtk_il_set_loadout_bluefor_{{class[0]}} = {
{{class[1]['gears']}}
{{class[1]['weapons']}}
};
{% endfor %}

// REDFOR weapons
{% for class in redfor %}
tvtmtk_il_set_loadout_redfor_{{class[0]}} = {
{{class[1]['gears']}}
{{class[1]['weapons']}}
};
{% endfor %}