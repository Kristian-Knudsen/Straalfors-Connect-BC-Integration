namespace Nsc.Persistance;

using Microsoft.Foundation.Company;
using Nsc.Core.Enums;
using System.Environment;

table 1000002 "Nsc Profile"
{
    DataClassification = AccountData;

    fields
    {
        field(1; ProfileId; Integer)
        {
            DataClassification = SystemMetadata;
        }

        field(2; CompanyName; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Company Information".Name);
        }

        field(3; AccountType; Enum "Nsc Account Type") { }

        field(4; CompanyId; Guid)
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Company.Id);
        }
    }

    keys
    {
        key(PrimaryKey; ProfileId)
        {
            Clustered = true;
        }
    }
}
