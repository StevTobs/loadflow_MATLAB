function output = calPower(Ykn, Vk, Vi, di, dk, tki)
    %Angle must be radian
    output = Vk * Ykn * Vi * cos( dk - di - tki );
    

end
