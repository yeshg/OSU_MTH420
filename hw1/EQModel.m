classdef EQModel
   properties
      masses
      spring_constants
   end
   methods
       function obj = EQModel(m_1,m_2,m_3,c_1,c_2,g)
           obj.masses = [m_1 + m_2, m_3];
           obj.spring_constants = [c_1,c_2];
       end
      function r = roundOff(obj)
         r = round([obj.Value],2);
      end
   end
end