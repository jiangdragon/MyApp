package frocessing.math
{

    public class MTRandom extends Object
    {
        private var mt:Array;
        private var mti:int = 625;
        private static const N:int = 624;
        private static const M:int = 397;
        private static const MATRIX_A:uint = 2.56748e+009;
        private static const UPPER_MASK:uint = 2.14748e+009;
        private static const LOWER_MASK:uint = 2147483647;

        public function MTRandom()
        {
            this.mt = new Array(N);
            return;
        }// end function

        public function randomSeed(param1:uint) : void
        {
            this.mti = 0;
            this.mt[0] = param1 & 4294967295;
            this.mti = 1;
            while (this.mti < N)
            {
                
                this.mt[this.mti] = this.$multi(1812433253, this.mt[uint((this.mti - 1))] ^ this.mt[uint((this.mti - 1))] >>> 30) + this.mti;
                this.mt[this.mti] = this.mt[this.mti] & 4294967295;
                var _loc_2:* = this;
                var _loc_3:* = this.mti + 1;
                _loc_2.mti = _loc_3;
            }
            return;
        }// end function

        public function randomSeedArray(param1:Array) : void
        {
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            var _loc_2:* = param1.length;
            this.randomSeed(19650218);
            _loc_3 = 1;
            _loc_4 = 0;
            _loc_5 = N > _loc_2 ? (N) : (_loc_2);
            while (_loc_5)
            {
                
                this.mt[_loc_3] = (this.mt[_loc_3] ^ this.$multi(this.mt[(_loc_3 - 1)] ^ this.mt[(_loc_3 - 1)] >>> 30, 1664525)) + param1[_loc_4] + _loc_4;
                this.mt[_loc_3] = this.mt[_loc_3] & 4294967295;
                _loc_3++;
                _loc_4++;
                if (_loc_3 >= N)
                {
                    this.mt[0] = this.mt[(N - 1)];
                    _loc_3 = 1;
                }
                if (_loc_4 >= _loc_2)
                {
                    _loc_4 = 0;
                }
                _loc_5 = _loc_5 - 1;
            }
            _loc_5 = N - 1;
            while (_loc_5)
            {
                
                this.mt[_loc_3] = (this.mt[_loc_3] ^ this.$multi(this.mt[(_loc_3 - 1)] ^ this.mt[(_loc_3 - 1)] >>> 30, 1566083941)) - _loc_3;
                this.mt[_loc_3] = this.mt[_loc_3] & 4294967295;
                _loc_3++;
                if (_loc_3 >= N)
                {
                    this.mt[0] = this.mt[(N - 1)];
                    _loc_3 = 1;
                }
                _loc_5 = _loc_5 - 1;
            }
            this.mt[0] = 2147483648;
            return;
        }// end function

        public function random() : Number
        {
            var _loc_1:uint = 0;
            var _loc_2:int = 0;
            if (this.mti >= N)
            {
                if (this.mti == (N + 1))
                {
                    this.randomSeed(5489);
                }
                _loc_2 = 0;
                while (_loc_2 < N - M)
                {
                    
                    _loc_1 = this.mt[_loc_2] & UPPER_MASK | this.mt[uint((_loc_2 + 1))] & LOWER_MASK;
                    this.mt[_loc_2] = this.mt[uint(_loc_2 + M)] ^ _loc_1 >>> 1 ^ (_loc_1 & 1) * MATRIX_A;
                    _loc_2++;
                }
                while (_loc_2 < (N - 1))
                {
                    
                    _loc_1 = this.mt[_loc_2] & UPPER_MASK | this.mt[uint((_loc_2 + 1))] & LOWER_MASK;
                    this.mt[_loc_2] = this.mt[uint(_loc_2 + (M - N))] ^ _loc_1 >>> 1 ^ (_loc_1 & 1) * MATRIX_A;
                    _loc_2++;
                }
                _loc_1 = this.mt[uint((N - 1))] & UPPER_MASK | this.mt[0] & LOWER_MASK;
                this.mt[uint((N - 1))] = this.mt[uint((M - 1))] ^ _loc_1 >>> 1 ^ (_loc_1 & 1) * MATRIX_A;
                this.mti = 0;
            }
            _loc_1 = this.mt[this.mti];
            _loc_1 = _loc_1 ^ _loc_1 >>> 11;
            _loc_1 = _loc_1 ^ _loc_1 << 7 & 2636928640;
            _loc_1 = _loc_1 ^ _loc_1 << 15 & 4022730752;
            _loc_1 = _loc_1 ^ _loc_1 >>> 18;
            var _loc_3:* = this;
            var _loc_4:* = this.mti + 1;
            _loc_3.mti = _loc_4;
            return _loc_1 / 4294967296;
        }// end function

        private function $multi(param1:uint, param2:uint) : uint
        {
            var _loc_3:* = param1 & 65535;
            var _loc_4:* = param1 >>> 16;
            var _loc_5:* = param2 & 65535;
            var _loc_6:* = param2 >>> 16;
            return (((_loc_3 * _loc_5 >>> 16) + _loc_3 * _loc_6 & 65535) + _loc_4 * _loc_5 & 65535) << 16 | _loc_3 * _loc_5 & 65535;
        }// end function

    }
}
