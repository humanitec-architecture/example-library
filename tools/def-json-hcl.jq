def json2hcl(prefix; escape_placeholders):
  if type == "object" then
    "{\n" + (
      . | [ to_entries[] | (
        prefix + "  \( .key | tojson ) = \( .value | json2hcl(prefix + "  "; escape_placeholders) )"
      )] | join("\n")
    ) + 
    "\n" + prefix + "}"
  elif type == "array" then
    "[\n" + (
      [.[] | (
        prefix + ( . | json2hcl(prefix + "  "; escape_placeholders))
      )] | join(",\n")
    ) +
    "\n" + prefix + "]"
  elif type == "string" then
    (. | split("\n") | if ((. | length) > 2) and ((. | last) == "") then
      "<<END_OF_TEXT\n" + (. | join("\n") | rtrimstr("\n") ) + "\nEND_OF_TEXT"
    else
      . | join("\n") | tojson
    end) | if escape_placeholders then . | sub("\\${"; "$${"; "g") else . end
  else
    (. | tojson )
  end
  ;
. | (if .kind != "Definition" then "Not a YAML Resource Definition\n" | halt_error else . end) | (
  .metadata.id as $id | .entity | (
    (
      @text "resource \"humanitec_resource_definition\" \"\( $id )\" {\n" +
      "  driver_type = \( .driver_type | tojson )\n" +
      "  id             = \( $id | tojson )\n" +
      "  name           = \( .name | tojson )\n" +
      "  type           = \( .type | tojson )\n" + (
        if . | has("driver_account") then
          "  driver_account = \( .driver_account | json2hcl("  "; true) )\n"
        else
          ""
        end
      ) + (
        if . | has("driver_inputs") then 
          .driver_inputs | (
            "  driver_inputs  = {\n" + (
              if .values then
                "    values_string  = jsonencode(\( .values | json2hcl("    "; true) ))\n" 
              else
                ""
              end
            ) + (
              if .secret_refs then
                "    secret_refs    = jsonencode(\( .secret_refs | json2hcl("    "; false) ))\n"
              elif .secrets then
                "    secrets_string = jsonencode(\( .secrets | json2hcl("    "; true) ))\n" 
              else
                ""
              end
            ) + 
            "  }\n"
          ) 
        else
          ""
        end
      ) + (
        if . | has("provision") then
          "\n  provision = {\n" + ([
            .provision | to_entries[] | (
              "    \( .key | tojson ) = {\n" + (
                if .value | has("is_dependent") then
                  "      is_dependent = \( .value.is_dependent )\n"
                else
                  ""
                end
              ) + (
                if .value | has("match_dependents") then
                  "      match_dependents = \( .value.match_dependents )\n"
                else
                  ""
                end
              ) +
              "    }\n"
            )
          ] | join("")) +
          "  }\n"
        else
          ""
        end
      )
    ) +
    "}\n", (
      if . | has("criteria") then [
        .criteria | to_entries[] | (
          "resource \"humanitec_resource_definition_criteria\" \"\( $id )_criteria_\(.key | tojson)\" {\n" +
          (
            "  resource_definition_id = resource.humanitec_resource_definition.\( $id ).id \n" +
            ([
              .value | to_entries[] | if .key != "id" then
                "  \(.key) = \( .value | tojson )"
              else
                empty
              end
            ] | join("\n")) + 
            "\n}"
          )
        ) 
      ] | join("\n\n")
      else
        empty
      end
    )
  )
)