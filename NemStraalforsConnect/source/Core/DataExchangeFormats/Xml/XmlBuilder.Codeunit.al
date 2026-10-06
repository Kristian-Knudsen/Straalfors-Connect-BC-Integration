namespace Nsc.Core.DataExchangeFormats.Xml;

codeunit 1000001 XmlBuilder
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

        XmlDoc.Add(XmlElement.Create(RootElementName, RootElementName));

        exit(XmlDoc);
    end;

    procedure AddElementWithValue(ElementName: Text; Value: Text; var Parent: XmlElement)
    var
        NewElement: XmlElement;
    begin
        NewElement := XmlElement.Create(ElementName);
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
        Parent.Add(XmlElement.Create(ElementName));
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
        GroupRoot := XmlElement.Create(GroupRootElementName);

        Parent.Add(GroupRoot);
    end;

    procedure AddElementGroup(GroupRootElementName: Text; var Parent: XmlElement; GroupRootElementNamespace: Text) GroupRoot: XmlElement
    begin
        GroupRoot := XmlElement.Create(GroupRootElementName, GroupRootElementNamespace);

        Parent.Add(GroupRoot);
    end;
}