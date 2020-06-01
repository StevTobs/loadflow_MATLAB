function output = calReactivePower(Ykn, Vk, Vi, di, dk, tki)
    %Angle must be radian
    output = Vk * Ykn * Vi * sin( dk - di - tki );
    

end
