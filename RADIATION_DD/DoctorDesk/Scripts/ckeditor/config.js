/**
 * @license Copyright (c) 2003-2021, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see https://ckeditor.com/legal/ckeditor-oss-license
 */

CKEDITOR.editorConfig = function(config) {
	// Define changes to default configuration here. For example:
	 //config.language = 'fr';
    // config.uiColor = '#AADC6E';
    //config.entities = false;
    config.pasteFromWordRemoveFontStyles = false;
    config.pasteFromWordRemoveStyles = false;
    config.entities = false;
    config.basicEntities = false;
    //config.entities_greek = false;
    config.entities_latin = false;
    config.autoParagraph = false;
 
    config.language = 'es';
    config.uiColor = '#F7B42C';
    config.toolbarCanCollapse = true;
    config.filebrowserUploadMethod = 'form'; 
    filebrowserUploadUrl: '/Scripts/ckeditor/Upload Images'; // Route
    filebrowserImageUploadUrl: '/Scripts/ckeditor/Upload Images'; // File location
};
