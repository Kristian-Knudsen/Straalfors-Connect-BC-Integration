namespace Nsc.Connect;

codeunit 1000003 "Nsc Xml Namespace Mapper"
{
    procedure GetNamespaceUri(NamespaceKey: Enum "Nsc Xml Namespaces"): Text
    var
    begin
        case NamespaceKey of
            Enum::"Nsc Xml Namespaces"::dkal:
                exit('urn:oio:dkal:1.0.0');

        end;

        Error('Unknown namespace provided. Value: %1 is not valid', NamespaceKey);
    end;
}