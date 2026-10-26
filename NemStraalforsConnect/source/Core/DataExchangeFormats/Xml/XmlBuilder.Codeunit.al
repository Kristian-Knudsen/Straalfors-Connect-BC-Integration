namespace Nsc.Core.DataExchangeFormats.Xml;
using Nsc.Connect;

codeunit 1000001 "Xml Builder"
{
    procedure CreateDocument(RootElementName: Text): XmlDocument
    var
        XmlDoc: XmlDocument;
    begin
        XmlDoc := XmlDocument.Create();

        XmlDoc.Add(XmlElement.Create(RootElementName));

        exit(XmlDoc);
    end;

    procedure CreateDocument(RootElementName: Text; RootElementNamespace: Text): XmlDocument
    var
        XmlDoc: XmlDocument;
    begin
        XmlDoc := XmlDocument.Create();
        XmlDoc.Add(XmlElement.Create(RootElementName, RootElementNamespace));

        exit(XmlDoc);
    end;

    procedure AddElementWithValue(ElementName: Text; Value: Text; var Parent: XmlElement)
    var
        NewElement: XmlElement;
    begin
        NewElement := XmlElement.Create(ElementName, Parent.NamespaceUri());
        NewElement.Add(XmlText.Create(Value));

        Parent.Add(NewElement);
    end;

    procedure AddElementWithValue(ElementName: Text; Value: Text; var Parent: XmlElement; Namespace: Text)
    var
        NewElement: XmlElement;
    begin
        NewElement := XmlElement.Create(ElementName, Namespace);
        NewElement.Add(XmlText.Create(Value));

        Parent.Add(NewElement);
    end;

    procedure AddElement(ElementName: Text; var Parent: XmlElement)
    begin
        Parent.Add(XmlElement.Create(ElementName, Parent.NamespaceUri()));
    end;

    procedure AddElement(ElementName: Text; var Parent: XmlElement; Namespace: Text)
    begin
        Parent.Add(XmlElement.Create(ElementName, Namespace));
    end;

    procedure AddAttribute(var Element: XmlElement; AttrKey: Text; AttrValue: Text)
    begin
        Element.SetAttribute(AttrKey, AttrValue);
    end;

    procedure AddElementGroup(GroupRootElementName: Text; var Parent: XmlElement) GroupRoot: XmlElement
    begin
        GroupRoot := XmlElement.Create(GroupRootElementName, Parent.NamespaceUri());

        Parent.Add(GroupRoot);
    end;

    procedure AddElementGroup(GroupRootElementName: Text; var Parent: XmlElement; GroupRootElementNamespace: Text) GroupRoot: XmlElement
    begin
        GroupRoot := XmlElement.Create(GroupRootElementName, GroupRootElementNamespace);

        Parent.Add(GroupRoot);
    end;

    procedure AddNamespace(var Element: XmlElement; Prefix: Text; NamespaceUri: Text)
    var
        XmlAttr: XmlAttribute;
        SplitPrefix: List of [Text];
    begin
        // If prefix contains 'xmlns:dkal' then the xmlns must be removed
        if Prefix.StartsWith('xmlns:') then begin
            SplitPrefix := Prefix.Split(':');
            Prefix := SplitPrefix.Get(2);
        end;

        if Prefix = 'xmlns' then
            Prefix := '';

        XmlAttr := XmlAttribute.CreateNamespaceDeclaration(Prefix, NamespaceUri);
        Element.Add(XmlAttr);
    end;

    procedure AddNamespace(var Element: XmlElement; Namespace: Enum "Nsc Xml Namespaces")
    var
        NamespaceMapper: Codeunit "Nsc Xml Namespace Mapper";
    begin
        AddNamespace(Element, Format(Namespace), NamespaceMapper.GetNamespaceUri(Namespace));
    end;
}