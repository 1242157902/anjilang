/**
 * @license Copyright (c) 2003-2013, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.html or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function( config ) {
	
	config.image_previewText=' '; //预览区域显示内容
	// 图片上传配置  
    config.filebrowserUploadUrl = 'upload.do?type=File';  
    config.filebrowserImageUploadUrl = '/anjilang/ckeditor/fileUpload.do?type=Images&filePath=ckeditor';//上传图片的保存路径
    config.filebrowserFlashUploadUrl = 'upload.do?type=Flash';  
      
    // 图片浏览配置  
    //config.filebrowserImageBrowseUrl = 'browerServer.do?type=image';  
	
	config.toolbarGroups = [
		{ name: 'document',	   groups: [ 'mode', 'document', 'doctools' ] }
		//,
		//{ name: 'clipboard',   groups: [ 'clipboard', 'undo' ] },
		//{ name: 'editing',     groups: [ 'find', 'selection', 'spellchecker' ] },
		//{ name: 'forms' },
		//{ name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ] },
		//{ name: 'paragraph',   groups: [ 'list', 'indent', 'blocks', 'align', 'bidi' ] },
		//{ name: 'links' },
		//{ name: 'insert' },
		//{ name: 'styles' },
		//{ name: 'colors' },
		//{ name: 'tools' },
		//{ name: 'others' },
		//{ name: 'about' }
	];

	//config.removeButtons = 'Cut,Copy,Paste,Undo,Redo,Anchor,Underline,Strike,Subscript,Superscript';

	//config.removeDialogTabs = 'image:advanced;link:advanced';
};

