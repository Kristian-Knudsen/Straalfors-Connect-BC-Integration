namespace Nsc.Connect;

using Nsc.Core.DataExchangeFormats.Xml;

codeunit 1000002 "Nsc Request Builder"
{
    var
        XmlBuilder: Codeunit "Xml Builder";
        NamespaceMapper: Codeunit "Nsc Xml Namespace Mapper";

    procedure PrepareDocumentAndReturnRoot(): XmlElement
    var
        Document: XmlDocument;
        DocumentRoot: XmlElement;
    begin
        Document := XmlBuilder.CreateDocument('ForsendelseI', 'urn:oio:fjernprint:3.0.0');

        Document.GetRoot(DocumentRoot);

        XmlBuilder.AddNamespace(DocumentRoot, Enum::"Nsc Xml Namespaces"::dkal);

        exit(DocumentRoot);
    end;

    procedure AddAfsendelseId(AfsendelseId: Text; var Parent: XmlElement)
    begin
        XmlBuilder.AddElementWithValue('AfsendelseIdentifikator', AfsendelseId, Parent);
    end;

    procedure AddForsendelseTypeId(ForsendelsesTypeId: Text; var Parent: XmlElement)
    begin
        XmlBuilder.AddElementWithValue('ForsendelseTypeIdentifikator', ForsendelsesTypeId, Parent);
    end;

    procedure AddForsendelseModtagerWithCpr(CprNumber: Text; var Parent: XmlElement)
    var
        GroupRoot: XmlElement;
        InnerGroupRoot: XmlElement;
    begin
        GroupRoot := XmlBuilder.AddElementGroup('ForsendelseModtager', Parent);
        InnerGroupRoot := XmlBuilder.AddElementGroup('AfsendelseModtager', GroupRoot, NamespaceMapper.GetNamespaceUri(Enum::"Nsc Xml Namespaces"::dkal));

        XmlBuilder.AddElementWithValue('CPRnummerIdentifikator', CprNumber, InnerGroupRoot, 'urn:oio:adir:dagpenge:2009.07.01');
    end;

    procedure AddFileFormatNamePdf(var Parent: XmlElement)
    begin
        XmlBuilder.AddElementWithValue('FilformatNavn', 'PDF', Parent, NamespaceMapper.GetNamespaceUri(Enum::"Nsc Xml Namespaces"::dkal));
    end;

    procedure AddForsendelseIndhold(Base64Indhold: Text; var Parent: XmlElement)
    begin
        XmlBuilder.AddElementWithValue('MeddelelseIndholdData', Base64Indhold, Parent, NamespaceMapper.GetNamespaceUri(Enum::"Nsc Xml Namespaces"::dkal));
    end;

    procedure AddDokumentParameters(var Parent: XmlElement)
    begin
        XmlBuilder.AddElement('DokumentParametre', Parent);
    end;

    procedure AddKanalUafhaengigeParametre(Username: Text; KanalKode: Text; var Parent: XmlElement)
    var
        GroupRoot: XmlElement;
    begin
        GroupRoot := XmlBuilder.AddElementGroup('KanalUafhaengigeParametreI', Parent);

        XmlBuilder.AddElementWithValue('BrugerNavn', Username, GroupRoot);
        XmlBuilder.AddElementWithValue('KanalKode', KanalKode, GroupRoot);
    end;
}