/**
 * Created by IntelliJ IDEA.
 * User: Gal
 * Date: 01.06.11
 * Time: 16:40
 * To change this template use File | Settings | File Templates.
 */
package {
    import flash.display.*;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.text.*;
    import flash.filters.DropShadowFilter;

    public class RectangeButton extends SimpleButton {
        private var _text:String;
        private var _width:Number;
        private var _height:Number;
        public var isActive:Boolean = false;

        public function RectangeButton(text:String, x:Number, y:Number, width:Number, height:Number){
            _text = text;
            this.x = x;
            this.y = y;
            _width = width;
            _height = height;
            upState = createRect(0x33FF66, false);
            overState = createRect(0x70FF94, false);
            downState = createRect(0xCCCCCC, true);
            hitTestState = upState;
        }

        public function createRect(color:uint, downState:Boolean):Sprite {
            var sprite:Sprite = new Sprite();
            var background:Shape = createdColoredRectangle( color );
            var textField:TextField = createTextField( downState );
            sprite.addChild( background );
            sprite.addChild( textField );
            return sprite;
        }

        private function createdColoredRectangle( color:uint ):Shape {
            var rect:Shape = new Shape();
            rect.graphics.lineStyle( 1, 0x000000 );
            rect.graphics.beginFill( color );
            rect.graphics.drawRoundRect( 0, 0, _width, _height, 10);
            rect.graphics.endFill();
            rect.filters = [ new DropShadowFilter( 2 ) ];
            return rect;
        }

        private function createTextField(downState:Boolean):TextField {
            var textField:TextField = new TextField();
            textField.text = _text;
            textField.width = _width;
            textField.height = _height;
            // Центрируем текст по горизонтали
            var format:TextFormat = new TextFormat();
            format.align = TextFormatAlign.CENTER;
            textField.setTextFormat( format );
            // Центрируем текст по вертикали
            textField.y = (_height - textField.textHeight ) / 2;
            textField.y -= 2; // Вычитаем 2 пиксела, чтобы обеспечить смещение
            // В состоянии «нажата» текст смещается вниз
            // и вправо относительно других состояний
            if (downState) {
                textField.x += 1;
                textField.y += 1;
            }
            return textField;
        }
    }
}
