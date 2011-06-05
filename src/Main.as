/**
 * Created by IntelliJ IDEA.
 * User: Gal
 * Date: 30.05.11
 * Time: 17:33
 * To change this template use File | Settings | File Templates.
 */
package {
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.DisplayObjectContainer;
    import flash.display.Loader;
    import flash.display.Sprite;
    import flash.display.DisplayObject;
    import flash.display.StageDisplayState;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.geom.Rectangle;
    import flash.net.URLLoader;
    import flash.net.URLLoaderDataFormat;
    import flash.net.URLRequest;

    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.display.*;
    import Constants.EnumBed;

    import flash.net.URLVariables;
    import flash.net.sendToURL;

    import flash.ui.Mouse;

    import flashx.textLayout.events.DamageEvent;

    import mx.controls.Image;

    public class Main extends Sprite {
        private var _loader:Loader = new Loader();
        private var massBed:Array = new Array();
        private var massIngBed:Array = new Array();
        private var plant:Bed;
        private var isGather:Boolean = false;
        private var globalID:int = 0;

        public function Main() {
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.displayState = StageDisplayState.FULL_SCREEN;
            stage.fullScreenSourceRect = new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight);

            massIngBed[1] = new Vector.<Bitmap>(5);
            massIngBed[2] = new Vector.<Bitmap>(5);
            massIngBed[3] = new Vector.<Bitmap>(5);

            CreateButtons();
            CreateFon();
        }

        private function CreateFon():void{
            _loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadFon);
            _loader.load(new URLRequest("BG.jpg"));
        }

        private function CreateButtons():void {
            var rectangeButton:RectangeButton;

            rectangeButton = new RectangeButton(Constants.EnumBed.TextClover, 1, 0, 120, 20);
            rectangeButton.addEventListener(MouseEvent.CLICK, CloverClick);
            DisplayObjectContainer(root).addChild(rectangeButton);

            rectangeButton = new RectangeButton(Constants.EnumBed.TextSunflower, 1, 25, 120, 20);
            rectangeButton.addEventListener(MouseEvent.CLICK, SunFlowerClick);
            DisplayObjectContainer(root).addChild(rectangeButton);

            rectangeButton = new RectangeButton(Constants.EnumBed.TextPotatoes, 1, 50, 120, 20);
            rectangeButton.addEventListener(MouseEvent.CLICK, PotatoClick);
            DisplayObjectContainer(root).addChild(rectangeButton);

            rectangeButton = new RectangeButton(Constants.EnumBed.TextGather, 1, 75, 120, 20);
            rectangeButton.addEventListener(MouseEvent.CLICK, GatherClick);
            DisplayObjectContainer(root).addChild(rectangeButton);

            rectangeButton = new RectangeButton(Constants.EnumBed.TextRun, 1, 100, 120, 20);
            rectangeButton.addEventListener(MouseEvent.CLICK, RunClick);
            DisplayObjectContainer(root).addChild(rectangeButton);
            /////////////////////////

            rectangeButton = new RectangeButton("Load XML", 1, 140, 120, 20);
            rectangeButton.addEventListener(MouseEvent.CLICK, LoadClick);
            DisplayObjectContainer(root).addChild(rectangeButton);
        }
////////BEGIN LoadXML
        private function LoadClick(event:MouseEvent):void{
            var xmlFile:URLLoader = new URLLoader();
            xmlFile.dataFormat = URLLoaderDataFormat.TEXT;
            xmlFile.load( new URLRequest( "REF.xml" ) );
            xmlFile.addEventListener(Event.COMPLETE, LoadXML);
        }

        private function LoadXML(event:Event):void{
            var bedXlm:XML = new XML(event.target.data);
            for each (var el:XML in bedXlm.elements()){
                for(var i:int = 0; i < massBed.length; i++){
                    if (massBed[i].ID == el.@id){
                        if (massBed[i].Run != el.@run){
                            massBed[i].Run = el.@run;
                            var loader:Loader = new Loader();
                            loader.name = massBed[i].ID;
                            if (massIngBed[massBed[i].Type][massBed[i].Run - 1] == null){
                                loader.contentLoaderInfo.addEventListener(Event.COMPLETE, OnLoadNewImg);
                                loader.load(new URLRequest(massBed[i].SRC + (massBed[i].Run + 1) + ".png"));
                            }
                            else{
                                var plant:Bed = Bed(DisplayObjectContainer(root).getChildByName(massBed[i].ID));
                                plant.removeChildAt(0);
                                plant.addChild(new Bitmap(massIngBed[massBed[i].Type][massBed[i].Run - 1].bitmapData));
                            }
                        }
                    }
                }
            }
        }

        private function OnLoadNewImg(event:Event):void{
            var image:Bitmap = Bitmap(event.target.content);
            var plant:Bed = Bed(DisplayObjectContainer(root).getChildByName(event.target.loader.name));
            plant.removeChildAt(0);
            plant.addChild(image);
        }
///////END LoadXML
        private function RunClick(event:MouseEvent):void{

        }

        private function GatherClick(event:MouseEvent):void{
            if (event.target.isActive){
                event.target.upState = event.target.createRect(0x33FF66, false);
                event.target.isActive = false;
                isGather = false;
            }
            else{
                event.target.upState = event.target.createRect(0xFF6500, false);
                event.target.isActive = true;
                isGather = true;
            }
        }

        private function CloverClick(event:MouseEvent):void{
            plant = new Bed(Constants.EnumBed.BedClover);
            if (massIngBed[Constants.EnumBed.BedClover][0] == null){
                _loader.contentLoaderInfo.addEventListener(Event.COMPLETE, OnLoadPlant);
                _loader.load(new URLRequest(plant.SRC + plant.Run + ".png"));
            }
            else{
                AddPlant(plant);
            }
        }

        private function PotatoClick(event:MouseEvent):void{
            plant = new Bed(Constants.EnumBed.BedPotatoes);
            if (massIngBed[Constants.EnumBed.BedPotatoes][0] == null){
                _loader.contentLoaderInfo.addEventListener(Event.COMPLETE, OnLoadPlant);
                _loader.load(new URLRequest(plant.SRC + plant.Run + ".png"));
            }
            else{
                AddPlant(plant);
            }
        }

        private function SunFlowerClick(event:MouseEvent):void{
            plant = new Bed(Constants.EnumBed.BedSunflower);
            if (massIngBed[Constants.EnumBed.BedSunflower][0] == null){
                _loader.contentLoaderInfo.addEventListener(Event.COMPLETE, OnLoadPlant);
                _loader.load(new URLRequest(plant.SRC + plant.Run + ".png"));
            }
            else{
                AddPlant(plant);
            }
        }

        private function OnLoadPlant(event:Event):void {
            var image:Bitmap = Bitmap(_loader.content);
            massIngBed[1][0] = image;
            AddPlant(plant);
        }

        private function AddPlant(plant:Bed):void{
            plant.ID = globalID++;
            plant.name = plant.ID.toString();
            plant.addChild(new Bitmap(massIngBed[1][0].bitmapData));
            plant.addEventListener(MouseEvent.MOUSE_DOWN, OnFonMOUSE_DOWN);
            plant.addEventListener(MouseEvent.MOUSE_UP, OnFonMOUSE_UP);
            plant.addEventListener(MouseEvent.CLICK, OnDeleteClick);
            DisplayObjectContainer(root).addChild(plant);
            plant.x = mouseX - plant.width/2;
            plant.y = mouseY - plant.height/2;
            plant.startDrag(false, new Rectangle(0, 0, stage.stageWidth, stage.stageHeight));
            massBed.push(plant);
        }

        private function OnDeleteClick(event:Event):void{
            if(isGather){
                //действие отравки на сервер
                ///....................
                DisplayObjectContainer(root).removeChild(Bed(event.target));
            }
        }

        private function onLoadFon(event:Event):void {
            var image:Bitmap = Bitmap(_loader.content);
            var sprite:Sprite = new Sprite();
            sprite.addChild(image);
            sprite.addEventListener(MouseEvent.MOUSE_DOWN, OnFonMOUSE_DOWN);
            sprite.addEventListener(MouseEvent.MOUSE_UP, OnFonMOUSE_UP);
            DisplayObjectContainer(root).addChild(sprite);
            DisplayObjectContainer(root).setChildIndex(sprite, 0);
        }

        private function OnFonMOUSE_DOWN(event:MouseEvent):void{
            event.target.startDrag(false,
                new Rectangle(stage.stageWidth - event.target.width,
                            stage.stageHeight - event.target.height,
                            event.target.width - stage.stageWidth,
                            event.target.height - stage.stageHeight));
        }

        public function OnFonMOUSE_UP(event:MouseEvent):void{
            //if (event.target.dropTarget != DisplayObjectContainer(root).getChildAt(1)){
                event.target.stopDrag();
        }

        private function CreateButton(text:String, x:int, y:int, height:int, width:int):void{

        }
    }
}