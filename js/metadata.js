function getFieldMetadata(field)
{
    const metadata =
    {
      "CSKSZ-KOSTL":
	{
	    variable: "COSTCENTER",
	    description: "Cost Center",
	    classification: "BUSINESS_KEY",
	    generator: "generate_costcenter()",
	    required: true
	},

      "CSKSZ-KTEXT":
	{
	    variable: "COSTCENTER_NAME",
	    description: "Cost Center Name",
	    classification: "DESCRIPTION",
	    generator: "generate_name()",
	    required: true
	},

      "CSKSZ-LTEXT":
	{
	    variable: "LONG_TEXT",
	    description: "Long Description",
	    classification: "LONG_DESCRIPTION",
	    generator: "generate_long_text()",
	    required: false
	},

      "CSKSZ-VERAK":
	{
	    variable: "RESPONSIBLE_PERSON",
	    description: "Responsible Person",
	    classification: "REFERENCE",
	    generator: "get_valid_responsible_person()",
	    required: true
	},

	"CSKSZ-PRCTR":
	{
	    variable: "PROFIT_CENTER",
	    description: "Profit Center",
	    classification: "REFERENCE",
	    generator: "get_valid_profit_center()",
	    required: true
	},
    };

    return metadata[field];
}