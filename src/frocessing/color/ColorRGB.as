package frocessing.color
{
    import frocessing.color.*;

    public class ColorRGB extends Object implements IColor
    {
        private var _r:uint;
        private var _g:uint;
        private var _b:uint;
        private var _a:Number;

        public function ColorRGB(param1:uint = 0, param2:uint = 0, param3:uint = 0, param4:Number = 1)
        {
            this.rgb(param1, param2, param3);
            this._a = param4;
            return;
        }// end function

        public function clone() : ColorRGB
        {
            return new ColorRGB(this._r, this._b, this._b, this._a);
        }// end function

        public function get value() : uint
        {
            return this._r << 16 | this._g << 8 | this._b;
        }// end function

        public function set value(param1:uint) : void
        {
            this._r = param1 >> 16 & 255;
            this._g = param1 >> 8 & 255;
            this._b = param1 & 255;
            return;
        }// end function

        public function get value32() : uint
        {
            return this.a8 << 24 | this._r << 16 | this._g << 8 | this._b;
        }// end function

        public function set value32(param1:uint) : void
        {
            this._r = param1 >> 16 & 255;
            this._g = param1 >> 8 & 255;
            this._b = param1 & 255;
            this._a = (param1 >>> 24) / 255;
            return;
        }// end function

        public function get a() : Number
        {
            return this._a;
        }// end function

        public function set a(param1:Number) : void
        {
            this._a = param1;
            return;
        }// end function

        private function get a8() : uint
        {
            return Math.round(this._a * 255) & 255;
        }// end function

        public function get r() : uint
        {
            return this._r;
        }// end function

        public function set r(param1:uint) : void
        {
            this._r = param1 & 255;
            return;
        }// end function

        public function get g() : uint
        {
            return this._g;
        }// end function

        public function set g(param1:uint) : void
        {
            this._g = param1 & 255;
            return;
        }// end function

        public function get b() : uint
        {
            return this._b;
        }// end function

        public function set b(param1:uint) : void
        {
            this._b = param1 & 255;
            return;
        }// end function

        public function rgb(param1:uint, param2:uint, param3:uint) : void
        {
            this._r = param1 & 255;
            this._g = param2 & 255;
            this._b = param3 & 255;
            return;
        }// end function

        public function gray(param1:uint) : void
        {
            var _loc_2:* = param1 & 255;
            this._b = param1 & 255;
            var _loc_2:* = _loc_2;
            this._g = _loc_2;
            this._r = _loc_2;
            return;
        }// end function

        public function toHSV() : ColorHSV
        {
            var _loc_1:* = new ColorHSV();
            _loc_1.rgb(this._r, this._g, this._b);
            _loc_1.a = this._a;
            return _loc_1;
        }// end function

        public function toString() : String
        {
            return "[RGB(" + this._r + "," + this._g + "," + this._b + ")A(" + this._a.toFixed(2) + ")]";
        }// end function

        public function valueOf() : uint
        {
            return this.value;
        }// end function

    }
}
