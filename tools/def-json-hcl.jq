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
  else
    (. | tojson | if escape_placeholders then . | sub("\\${"; "$${") end)
  end
  ;
. | (if .kind != "Definition" then "Not a YAML Resource Definition\n" | halt_error  end) | (
  .metadata.id as $id | .entity | (
    (
      @text "resource \"humanitec_resource_definition\" \"\( $id )\" {\n" +
      "  driver_type = \( .driver_type | tojson )\n" +
      "  id             = \( $id | tojson )\n" +
      "  name           = \( $id | tojson )\n" +
      "  type           = \( .type | tojson )\n" + (
        if . | has("driver_account") then
          "  driver_account = \( .driver_account | sub("$\\{"; "$${}") | tojson )\n"
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
                "    secrets_string = jsonencode(\( .secrets | json2hcl("    "; false) ))\n" 
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
          "\n  provision = {\n" + (
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
          ) +
          "  }\n"
        else
          ""
        end
      )
    ) +
    "}\n", (
      if . | has("criteria") then [
        .criteria | to_entries[] | (
          "resource \"humanitec_resource_definition_criteria\" \( $id )_criteria_\(.key | tojson) " + (
            (
              .value + {"resource_definition_id" : $id}
            ) | del(.id) | json2hcl(""; false)
          )
        ) 
      ] | join("\n\n")
      else
        empty
      end
    )
  )
)